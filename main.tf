module "instancias" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-instancias.git?ref=v1.0.3"
  source = "../Modulo-instancias/"

  numero_de_ec2  = 1
  tipo_instancia = "t3.micro"

  tags = {
    Name        = "Projeto_Final"
    Terraform   = "Sim"
    Environment = "Dev"
    Backup      = "true"
  }
}


module "iam_policy_role" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-iam.git?ref=v1.0.4"
  source = "../Modulo-iam/"

  #Criação da politica para EC2
  policy_name        = "Inicia_Desliga_EC2"
  policy_description = "Policy que permite o Lambda a desligar e ligar as instâncias EC2"

  #Criação da role para EC2
  role_name        = "Inicia_Desliga_EC2"
  role_description = "Função que permite o Lambda a desligar e ligar as instâncias EC2"

  #Criação de role para AWSBackup
  nome_role_backup        = "role_backup"
  description_role_backup = "Função que permite o cofre gerenciar os backups"
}

module "lambda_inicia" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-lambda-inicia.git?ref=v1.0.4"
  source                   = "../Modulo-lambda-inicia/"
  nome_funcao_inicia       = "IniciaEC2"
  instancia_id             = module.instancias.instance_id
  role                     = module.iam_policy_role.iam_role_arn_ec2
  tamanho_memoria          = 128
  timeout                  = 3
  armazenamento_temporario = 512
  rastreio_log             = "Active"

}

module "lambda_desliga" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-lambda-desliga.git?ref=v1.0.3"
  source                   = "../Modulo-lambda-desliga/"
  nome_funcao_desliga      = "DesligaEC2"
  instancia_id             = module.instancias.instance_id
  role                     = module.iam_policy_role.iam_role_arn_ec2
  tamanho_memoria          = 128
  timeout                  = 3
  armazenamento_temporario = 512
  rastreio_log             = "Active"

}

module "cloudwatch_inicia" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-cloudwatch-inicia.git?ref=v1.0.2"
  source                        = "../Modulo-cloudwatch-inicia/"
  cloudwatch_inicia_name        = "Horario_de_inicio"
  agendamento_cron              = "cron(0 8 ? * MON-FRI *)"
  estado                        = "ENABLED"
  evento_cloudwatch             = "default"
  cloudwatch_inicio_description = "Agendamento para desligar as instancias"
  statement_id                  = "permite_EventBridge_executar_lambda_inicia"
  nome_alvo                     = "Funcao_Lambda_IniciaEC2"
  lambda_function_arn_inicia    = module.lambda_inicia.lambda_function_arn
  lambda_function_name_inicia   = module.lambda_inicia.lambda_function_name_inicia
}

module "cloudwatch_desliga" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-cloudwatch-desliga.git?ref=v1.0.2"
  source                         = "../Modulo-cloudwatch-desliga/"
  cloudwatch_desliga_name        = "Horario_de_desligamento"
  agendamento_cron               = "cron(0 22 ? * MON-FRI *)"
  estado                         = "ENABLED"
  evento_cloudwatch              = "default"
  cloudwatch_desliga_description = "Agendamento para desligar as instancias"
  statement_id                   = "permite_EventBridge_executar_lambda_desliga"
  nome_alvo                      = "Funcao_Lambda_DesligaEC2"
  lambda_function_arn_desliga    = module.lambda_desliga.lambda_function_arn
  lambda_function_name_desliga   = module.lambda_desliga.lambda_function_name_desliga
}

module "Backup" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-bakcup.git?ref=v1.0.3"
  source                       = "../Modulo-bakcup/"
  nome_cofre                   = "cofre_backup_tag"
  force_destruir               = true
  nome_plano_backup            = "plano_backup_tag"
  nome_regra                   = "backup_tag_diario"
  agendamento_backup           = "cron(0 15 * * ? *)" # agendametno é feito conforme horário UTC +00
  inicio_manutencao            = 60                   #Especifique(em minutos) o período em que o plano de backup será iniciado, caso não comece no horário especificado.
  janela_manutencao            = 180                  #Defina(em minutos) o período durante o qual o backup deve ser concluído antes de retornar qualquer erro por timeout.
  quantidade_dias_para_delecao = 7
  nome_selecao_alvo_tag        = "selecao_alvo_tag"
  iam_role_arn_backup          = module.iam_policy_role.iam_role_arn_backup
  selecao_recurso_tag_type     = "STRINGEQUALS"
  selecao_recurso_tag_key      = "Backup"
  selecao_recurso_tag_value    = "true"
}
