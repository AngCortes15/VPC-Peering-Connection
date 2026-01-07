#VPC INFORMATIO

output "lab_vpc_id" { #Mostrar ID de Lab VPC
    description = "ID of Lab VPC"
    value       = data.aws_vpc.lab_vpc.id
}

output "lab_vpc_cidr" { #Mostrar CIDR block de Lab VPC (rango de IPs)
    description = "CIDR block of Lab VPC"
    value       = data.aws_vpc.lab_vpc.cidr_block
}

output "shared_vpc_id" { #Mostrar ID de Shared VPC
    description = "ID of Shared VPC"
    value       = data.aws_vpc.shared_vpc.id
}

output "shared_vpc_cidr" { #Mostrar CIDR block de Shared VPC
    description = "CIDR block of Shared VPC"
    value       = data.aws_vpc.shared_vpc.cidr_block
}

#VPC PEERING INFORMATION

output "vpc_peering_id" { #ID del VPC Peering Connection
    description = "ID of VPC Peering Connection"
    value       = aws_vpc_peering_connection.lab_peer.id
}

output "vpc_peering_status" { #Estado de la conexión de peering
    description = "Status of VPC Peering Connection"
    value       = aws_vpc_peering_connection.lab_peer.accept_status
}

output "vpc_peering_details" { #Mostrar información completa del peering (útil para debugging)

    description = "Full details of VPC Peering Connection"
    value = {
        id            = aws_vpc_peering_connection.lab_peer.id
        status        = aws_vpc_peering_connection.lab_peer.accept_status
        requester_vpc = data.aws_vpc.lab_vpc.id
        accepter_vpc  = data.aws_vpc.shared_vpc.id
    }
}

#ROUTE TABLES INFORMATION
output "lab_route_table_id" {
  description = "ID of lab Public Route Table"
  value = data.aws_route_table.lab_public_route_table.id
}

output "shared_route_table_id" {
  description = "ID of Shared-VPC Route Table"
  value = data.aws_route_table.shared_vpc_route_table.id
}

# VPC FLOW LOGS INFORMATION
output "flow_log_id" { #ID del VPC Flow Log
description = "ID of VPC Flow Log for Shared VPC"
value       = aws_flow_log.shared_vpc_flow_log.id
}

output "flow_log_destination" { #Destino del Flow Log (CloudWatch Log Group)
description = "CloudWatch Log Group ARN for VPC Flow Logs"
value       = aws_flow_log.shared_vpc_flow_log.log_destination
}

output "flow_log_status" { #Estado del Flow Log
description = "Status of VPC Flow Log"
value       = aws_flow_log.shared_vpc_flow_log.id != "" ? "Active" : "Unknown"
}
