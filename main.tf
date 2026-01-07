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