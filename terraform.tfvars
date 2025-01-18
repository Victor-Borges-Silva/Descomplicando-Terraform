#================================================================================
# module instancias
#================================================================================
numero_de_ec2  = 1
tipo_instancia = "t3.micro"

#tags = [
#  {
#    Name        = "Projeto_Final"
#    Terraform   = "Sim"
#    Environment = "Dev"
#    Backup      = "true"
#  }
#]

#================================================================================
# module iam_policy_role
#================================================================================
#modulo_iam_policy_role = [
#  {
#    #Criação da policy para EC2
#    policy_name        = "Inicia_Desliga_EC2"
#    policy_description = "Policy que permite o Lambda a desligar e ligar as instâncias EC2"
#
#    #Criação da role para EC2
#    role_name        = "Inicia_Desliga_EC2"
#    role_description = "Função que permite o Lambda a desligar e ligar as instâncias EC2"
#
#    #Criação de role para AWSBackup
#    nome_role_backup        = "role_backup"
#    description_role_backup = "Função que permite o cofre gerenciar os backups"
#  }
#]
#================================================================================
#Criação da policy para EC2
policy_name        = "Inicia_Desliga_EC2"
policy_description = "Policy que permite o Lambda a desligar e ligar as instâncias EC2"

#Criação da role para EC2
role_name        = "Inicia_Desliga_EC2"
role_description = "Função que permite o Lambda a desligar e ligar as instâncias EC2"

#Criação de role para AWSBackup
nome_role_backup        = "role_backup"
description_role_backup = "Função que permite o cofre gerenciar os backups"

#================================================================================
# module lambda_inicia && lambda_desliga
#================================================================================
nome_funcao_inicia       = "IniciaEC2"
nome_funcao_desliga      = "DesligaEC2"
tamanho_memoria          = 128
timeout                  = 3
armazenamento_temporario = 512
rastreio_log             = "Active"

#================================================================================
# module cloudwatch_inicia
#================================================================================
cloudwatch_inicia_name        = "Horario_de_inicio"
agendamento_cron              = "cron(0 8 ? * MON-FRI *)"
estado                        = "ENABLED"
evento_cloudwatch             = "default"
cloudwatch_inicio_description = "Agendamento para desligar as instancias"
statement_id                  = "permite_EventBridge_executar_lambda_inicia"
nome_alvo                     = "Funcao_Lambda_IniciaEC2"

#================================================================================
# module cloudwatch_desliga
#================================================================================
desliga_cloudwatch_desliga_name        = "Horario_de_desligamento"
desliga_agendamento_cron               = "cron(0 22 ? * MON-FRI *)"
desliga_estado                         = "ENABLED"
desliga_evento_cloudwatch              = "default"
desliga_cloudwatch_desliga_description = "Agendamento para desligar as instancias"
desliga_statement_id                   = "permite_EventBridge_executar_lambda_desliga"
desliga_nome_alvo                      = "Funcao_Lambda_DesligaEC2"

#================================================================================
# module Backup
#================================================================================
nome_cofre                   = "cofre_backup_tag"
force_destruir               = true
nome_plano_backup            = "plano_backup_tag"
nome_regra                   = "backup_tag_diario"
agendamento_backup           = "cron(0 15 * * ? *)"
inicio_manutencao            = 60
janela_manutencao            = 180
quantidade_dias_para_delecao = 7
nome_selecao_alvo_tag        = "selecao_alvo_tag"
selecao_recurso_tag_type     = "STRINGEQUALS"
selecao_recurso_tag_key      = "Backup"
selecao_recurso_tag_value    = "true"