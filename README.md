# VPC Peering Connection Lab

Laboratorio de AWS para aprender a crear y configurar una VPC Peering Connection usando Terraform.

## Objetivo del Laboratorio

Este laboratorio enseña cómo conectar dos VPCs privadamente para permitir comunicación entre recursos en diferentes redes usando VPC Peering.

### Objetivos de Aprendizaje

- ✅ Crear una VPC peering connection
- 🚧 Configurar route tables para usar VPC peering
- ⏳ Habilitar VPC Flow Logs para análisis de tráfico de red
- ⏳ Probar la conexión de peering
- ⏳ Analizar VPC flow logs

## Arquitectura

```
┌─────────────────────────────────┐      ┌─────────────────────────────────┐
│  Lab VPC (10.0.0.0/16)          │      │  Shared VPC (10.5.0.0/16)       │
│                                 │      │                                 │
│  ┌──────────────────────────┐   │      │  ┌──────────────────────────┐   │
│  │ Public Subnet            │   │      │  │ Private Subnet 1         │   │
│  │ (10.0.0.0/24)            │   │      │  │ (10.5.0.0/23)            │   │
│  │                          │   │      │  │                          │   │
│  │ ┌──────────────────────┐ │   │      │  │ ┌──────────────────────┐ │   │
│  │ │ Application Server   │ │   │◄────►│  │ │ MySQL RDS Instance   │ │   │
│  │ │ (EC2)                │ │   │      │  │ │                      │ │   │
│  │ └──────────────────────┘ │   │      │  │ └──────────────────────┘ │   │
│  └──────────────────────────┘   │      │  └──────────────────────────┘   │
│                                 │      │                                 │
│  ┌──────────────────────────┐   │      │  ┌──────────────────────────┐   │
│  │ Private Subnet           │   │      │  │ Private Subnet 2         │   │
│  │ (10.0.2.0/23)            │   │      │  │ (10.5.2.0/23)            │   │
│  └──────────────────────────┘   │      │  └──────────────────────────┘   │
└─────────────────────────────────┘      └─────────────────────────────────┘
              ▲                                        ▲
              │                                        │
              └────────── VPC Peering (Lab-Peer) ─────┘
                         pcx-0c6d5be7671e82bf0
```

## Progreso Actual

### ✅ Completado

1. **Configuración inicial de Terraform**
   - Provider de AWS configurado
   - Variables definidas
   - Outputs configurados

2. **VPC Peering Connection**
   - Creado con ID: `pcx-0c6d5be7671e82bf0`
   - Estado: `active`
   - Conecta Lab VPC ↔ Shared VPC

### 🚧 Siguiente Paso: Configurar Route Tables

El VPC Peering está creado pero **no funcional todavía**. Necesita rutas en las route tables de ambas VPCs.

**Qué hacer:**
- Agregar ruta en Lab VPC → destino: `10.5.0.0/16` → target: peering connection
- Agregar ruta en Shared VPC → destino: `10.0.0.0/16` → target: peering connection

### ⏳ Pendiente

- Habilitar VPC Flow Logs
- Probar conectividad entre Application Server y MySQL
- Analizar Flow Logs

## Estructura del Proyecto

```
VPC-Peering-Connection/
├── provider.tf          # Configuración del provider AWS
├── variables.tf         # Variables de entrada
├── main.tf              # Data sources y recursos
├── outputs.tf           # Información de salida
├── terraform.tfstate    # Estado actual (generado automáticamente)
├── CLAUDE.md           # Guía para Claude Code
└── README.md           # Este archivo
```

## Comandos Terraform

### Inicializar proyecto
```bash
terraform init
```

### Validar configuración
```bash
terraform validate
```

### Ver plan de cambios
```bash
terraform plan
```

### Aplicar cambios
```bash
terraform apply
```

### Ver outputs
```bash
terraform output
```

### Ver estado actual
```bash
terraform show
```

### Destruir recursos
```bash
terraform destroy
```

## Recursos Creados por Terraform

- VPC Peering Connection: `Lab-Peer` (pcx-0c6d5be7671e82bf0)

## Recursos Pre-existentes (consultados)

- Lab VPC: vpc-0159d9ad4928cfac2 (10.0.0.0/16)
- Shared VPC: vpc-0de1e63687b2d35f6 (10.5.0.0/16)
- Application Server (EC2)
- MySQL RDS Instance

## Información Importante

- **Región:** us-east-1
- **Estilo de código:** Terraform en inglés, comentarios en español
- **Objetivo educativo:** Aprender AWS y Terraform con mentoría paso a paso

## Próximos Pasos

1. Configurar route tables con recursos `aws_route`
2. Habilitar VPC Flow Logs con IAM roles y CloudWatch Log Groups
3. Probar conectividad Application Server → MySQL
4. Analizar logs en CloudWatch

---

**Última actualización:** 2026-01-06
**Estado:** VPC Peering creado, pendiente configuración de rutas
