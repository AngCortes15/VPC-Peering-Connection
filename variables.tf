#Variables para definir la region de AWS
variable "aws_region" {
  description = "AWS region where resources will be created"
  type = string
  default = "us-east-1"
}

variable "availability_zone" { #Availability Zones a utilizar para alta disponibilidad
  description = "Availability zones to use for resources"
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "lab_vpc_name" { #Nombre de Lab VPC (para buscarla por tag)
description = "Name tag of the existing Lab VPC"
type        = string
default     = "Lab VPC"
}

variable "shared_vpc_name" { #Nombre de Shared VPC (para buscarla por tag)
description = "Name tag of the existing Shared VPC"
type        = string
default     = "Shared VPC"
}

#CONFIGURACIÓN DE VPC FLOW LOGS
variable "flow_logs_retention_days" {
description = "Number of days to retain VPC Flow Logs"
type        = number
default     = 7
}

variable "flow_logs_traffic_type" {
description = "Type of traffic to capture (ACCEPT, REJECT, or ALL)"
type        = string
default     = "ALL"
}