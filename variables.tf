#================================================================================
# module instancias
#================================================================================
variable "numero_de_ec2" {
  type        = number
  description = "Quantidade de instancias EC2 a ser provisionada"
}

variable "tipo_instancia" {
  type        = string
  description = "Tipo de instancia EC2 a ser provisionada"
}

variable "tags" {
  type = set(object({
    Name        = string
    Terraform   = string
    Environment = string
    Backup      = string
  }))

  description = "Etiqueta para as instancias EC2"
}


#================================================================================
# module iam_policy_role
#================================================================================

#variable "modulo_iam_policy_role" {
#  description = "Lista da variaveis que serão usadas no modulo iam_policy_role"
#  type = set(object({
#    policy_name        = string
#    policy_description = string
#    role_name               = string
#    role_description = string
#    nome_role_backup        = string
#    description_role_backup = string
#  }))
#}

variable "policy_name" {
  type        = string
  description = "Nome da politica"
}

variable "policy_description" {
  type    = string
  default = "Default_Varibletf"
}

variable "role_name" {
  type        = string
  description = "Nome da Funcao"
}

variable "role_description" {
  type        = string
  description = "Nome da role"
}


#IAM Role para o plano de backup
variable "nome_role_backup" {
  type        = string
  description = "Nome da role/função para permitir o AWSBackup gerenciar os pontos de restauração"
}

variable "description_role_backup" {
  type        = string
  description = "Descrição para função IAM que permite o cofre gerenciar os backups"
}
