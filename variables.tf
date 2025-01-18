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

#variable "tags" {
#  description = "Etiqueta para as instancias EC2"
#  type = set(object({
#    Name        = string
#    Terraform   = string
#    Environment = string
#    Backup      = string
#  }))
#}

#================================================================================
# module iam_policy_role
#================================================================================

#variable "modulo_iam_policy_role" {
#  description = "Lista da variaveis que serão usadas no modulo iam_policy_role"
#  type = set(object({
#    policy_description      = string
#    role_description        = string
#    description_role_backup = string
#  }))
#}

variable "policy_name" {
  type        = string
  description = "Nome da politica"
}

variable "policy_description" {
  type        = string
  description = "description"
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
#================================================================================
# module lambda_inicia
#================================================================================
variable "nome_funcao_inicia" {
  type        = string
  description = "description"
}

variable "nome_funcao_desliga" {
  type        = string
  description = "description"
}

variable "tamanho_memoria" {
  type        = number
  description = "description"
}

variable "timeout" {
  type        = number
  description = "description"
}

variable "armazenamento_temporario" {
  type        = number
  description = "description"
}

variable "rastreio_log" {
  type        = string
  description = "description"
}

#================================================================================
# module cloudwatch_inicia
#================================================================================
variable "cloudwatch_inicia_name" {
  type        = string
  description = "Nome do CloudWatch Inicia"
}

variable "agendamento_cron" {
  type        = string
  description = "Agendamento em formato cron para iniciar a função"
}

variable "estado" {
  type        = string
  description = "Estado da instância ou recurso"
}

variable "evento_cloudwatch" {
  type        = string
  description = "Descrição do evento do CloudWatch"
}

variable "cloudwatch_inicio_description" {
  type        = string
  description = "Descrição para o início do CloudWatch"
}

variable "statement_id" {
  type        = string
  description = "ID do statement para a política"
}

variable "nome_alvo" {
  type        = string
  description = "Nome do alvo da função ou evento"
}

#================================================================================
# module cloudwatch_desliga
#================================================================================
variable "desliga_cloudwatch_desliga_name" {
  type        = string
  description = "Nome do CloudWatch para Desligar"
}

variable "desliga_agendamento_cron" {
  type        = string
  description = "Agendamento em formato cron para desligar a função"
}

variable "desliga_estado" {
  type        = string
  description = "Estado da instância ou recurso no processo de desligamento"
}

variable "desliga_evento_cloudwatch" {
  type        = string
  description = "Descrição do evento do CloudWatch para desligamento"
}

variable "desliga_cloudwatch_desliga_description" {
  type        = string
  description = "Descrição para o desligamento no CloudWatch"
}

variable "desliga_statement_id" {
  type        = string
  description = "ID do statement para a política de desligamento"
}

variable "desliga_nome_alvo" {
  type        = string
  description = "Nome do alvo da função ou evento de desligamento"
}

#================================================================================
# module Backup
#================================================================================
variable "nome_cofre" {
  type        = string
  description = "Nome do Cofre"
}

variable "force_destruir" {
  type        = bool
  description = "Flag para forçar a destruição"
}

variable "nome_plano_backup" {
  type        = string
  description = "Nome do plano de backup"
}

variable "nome_regra" {
  type        = string
  description = "Nome da regra"
}

variable "agendamento_backup" {
  type        = string
  description = "Agendamento do backup"
}

variable "inicio_manutencao" {
  type        = number
  description = "Data e hora de início da manutenção"
}

variable "janela_manutencao" {
  type        = number
  description = "Janela de tempo para a manutenção"
}

variable "quantidade_dias_para_delecao" {
  type        = number
  description = "Quantidade de dias para a deleção"
}

variable "nome_selecao_alvo_tag" {
  type        = string
  description = "Nome da tag do alvo de seleção"
}

variable "selecao_recurso_tag_type" {
  type        = string
  description = "Tipo da tag para seleção de recurso"
}

variable "selecao_recurso_tag_key" {
  type        = string
  description = "Chave da tag para seleção de recurso"
}

variable "selecao_recurso_tag_value" {
  type        = string
  description = "Valor da tag para seleção de recurso"
}
