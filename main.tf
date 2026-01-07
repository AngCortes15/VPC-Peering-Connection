#Data Sources - Recursos existentes
data "aws_vpc" "lab_vpc" { #Obtener Lab VPC existente
  filter {
    name = "tag:Name"
    values = [var.lab_vpc_name]
  }
}

data "aws_vpc" "shared_vpc" { #Obtener Shared VPC existente
  filter {
    name = "tag:Name"
    values = [ var.shared_vpc_name ]    
  }
}


data "aws_route_table" "lab_public_route_table" { #Obtener route tables de Lab VPC
  vpc_id = data.aws_vpc.lab_vpc.id
  filter {
    name = "tag:Name"
    values = [ "Lab Public Route Table" ]
  }
}

data "aws_route_table" "shared_vpc_route_table" { #Obtener route tables de Shared VPC
  vpc_id = data.aws_vpc.shared_vpc.id
  filter {
    name = "tag:Name"
    values = [ "Shared-VPC Route Table" ]
  }
}

#VPC PEERING CONNECTION
resource "aws_vpc_peering_connection" "lab_peer" {
  vpc_id = data.aws_vpc.lab_vpc.id #VPC requester
  peer_vpc_id = data.aws_vpc.shared_vpc.id #VPC accepter
  auto_accept = true #Auto-aceptar porque estan en la misma cuenta

  tags = {
    Name = "Lab-Peer"
    Side = "Requester"
  }
}

#CONFIGURACION DE RUTAS PARA VPC PEERING

resource "aws_route" "lab_to_shared" { #Ruta en Lab VPC: Enviar tráfico a Shared VPC (10.5.0.0/16) por el peering
  route_table_id = data.aws_route_table.lab_public_route_table.id
  destination_cidr_block = data.aws_vpc.shared_vpc.cidr_block #10.5.0.0/16
  vpc_peering_connection_id = aws_vpc_peering_connection.lab_peer.id
}

resource "aws_route" "shared_to_lab" {
  route_table_id = data.aws_route_table.shared_vpc_route_table.id
  destination_cidr_block = data.aws_vpc.lab_vpc.cidr_block #10.0.0.0/16
  vpc_peering_connection_id = aws_vpc_peering_connection.lab_peer.id
}

# VPC FLOW LOGS CONFIGURATION

# IAM Role para VPC Flow Logs (pre-existente en el lab)
data "aws_iam_role" "vpc_flow_logs_role" {
  name = "vpc-flow-logs-Role"
}

# Data source para obtener Account ID (necesario para construir el ARN del log group)
data "aws_caller_identity" "current" {}

# VPC Flow Log para Shared VPC
# El CloudWatch Log Group se creará automáticamente (como en la consola)
resource "aws_flow_log" "shared_vpc_flow_log" {
  vpc_id                   = data.aws_vpc.shared_vpc.id
  traffic_type             = var.flow_logs_traffic_type
  iam_role_arn             = data.aws_iam_role.vpc_flow_logs_role.arn
  log_destination_type     = "cloud-watch-logs"

  # ARN del log group que AWS creará automáticamente
  log_destination          = "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:ShareVPCFlowLogs"

  max_aggregation_interval = 60  # 1 minuti
}