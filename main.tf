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


data "aws_route_tables" "lab_vpc_route_tables" { #Obtener route tables de Lab VPC
vpc_id = data.aws_vpc.lab_vpc.id
}

data "aws_route_tables" "shared_vpc_route_tables" { #Obtener route tables de Shared VPC
vpc_id = data.aws_vpc.shared_vpc.id
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