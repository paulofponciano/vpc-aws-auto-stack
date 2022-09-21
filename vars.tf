# REGIAO DO PROVISIONAMENTO
variable "AWS_REGION" {
  default = "us-east-1"
}

# PRIMEIRA ZONA DE DISPONIBILIDATE (NAT GATEWAY PROVISIONADO NESTA AZ)
variable "az1" {
  default = "us-east-1a"
}

# SEGUNDA ZONA DE DISPONIBILIDADE
variable "az2" {
  default = "us-east-1b"
}

# USAR AQUI A IDENTIFICACAO DO AMBIENTE
variable "customer_env" {
  default = "company"
}

# CIDR VPC
variable "vpc_cidr_block" {
  default = "172.32.0.0/16"
}

# SUBNET PUBLICA (NAT GATEWAY PROVISIONADO NESTA SUBNET)
variable "subnet_public_1_cidr" {
  default = "172.32.0.0/20"
}

# SUBNET PUBLICA
variable "subnet_public_2_cidr" {
  default = "172.32.16.0/20"
}

# SUBNET PRIVADA
variable "subnet_private_1_cidr" {
  default = "172.32.32.0/20"
}

# SUBNET PRIVADA
variable "subnet_private_2_cidr" {
  default = "172.32.48.0/20"
}