module "instancias" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-instancias.git?ref=v1.0.4"
  source = "../Modulo-instancias/"

  numero_de_ec2  = var.numero_de_ec2
  tipo_instancia = var.tipo_instancia

  #for_each = { for atributo in var.tags : atributo.Name => atributo }
  #tags = {
  #  Name        = each.value.Name
  #  Terraform   = each.value.Terraform
  #  Environment = each.value.Environment
  #  Backup      = each.value.Backup
  #}

  tags = {
    Name        = "Projeto_Final"
    Terraform   = "Sim"
    Environment = "Dev"
    Backup      = "true"
  }

}


module "iam_policy_role" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-iam.git?ref=v1.0.5"
  source = "../Modulo-iam/"
  #  for_each = { for idx, atributo in var.modulo_iam_policy_role : idx.atributo => idx }
  #
  #  #Criação da politica para EC2
  #  policy_name        = each.value.policy_name
  #  policy_description = each.value.policy_description
  #
  #  #Criação da role para EC2
  #  role_name        = each.value.role_name
  #  role_description = each.value.role_description
  #
  #  #Criação de role para AWSBackup
  #  nome_role_backup        = each.value.nome_role_backup
  #  description_role_backup = each.value.description_role_backup

  #Criação da politica para EC2
  policy_name        = var.policy_name
  policy_description = var.policy_description

  #Criação da role para EC2
  role_name        = var.role_name
  role_description = var.role_description

  #Criação de role para AWSBackup
  nome_role_backup        = var.nome_role_backup
  description_role_backup = var.description_role_backup
}

locals {
  instance_id = tolist(module.instancias.instance_id)
}

module "lambda_inicia" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-lambda-inicia.git?ref=v1.0.5"
  source                   = "../Modulo-lambda-inicia/"
  nome_funcao_inicia       = var.nome_funcao_inicia
  instancia_id             = local.instance_id
  role                     = module.iam_policy_role.iam_role_arn_ec2
  tamanho_memoria          = var.tamanho_memoria
  timeout                  = var.timeout
  armazenamento_temporario = var.armazenamento_temporario
  rastreio_log             = var.rastreio_log

  depends_on = [module.iam_policy_role]
}

module "lambda_desliga" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-lambda-desliga.git?ref=v1.0.4"
  source                   = "../Modulo-lambda-desliga/"
  nome_funcao_desliga      = var.nome_funcao_desliga
  instancia_id             = local.instance_id
  role                     = module.iam_policy_role.iam_role_arn_ec2
  tamanho_memoria          = var.tamanho_memoria
  timeout                  = var.timeout
  armazenamento_temporario = var.armazenamento_temporario
  rastreio_log             = var.rastreio_log

  depends_on = [module.iam_policy_role]
}

module "cloudwatch_inicia" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-cloudwatch-inicia.git?ref=v1.0.3"
  source                        = "../Modulo-cloudwatch-inicia/"
  cloudwatch_inicia_name        = var.cloudwatch_inicia_name
  agendamento_cron              = var.agendamento_cron
  estado                        = var.estado
  evento_cloudwatch             = var.evento_cloudwatch
  cloudwatch_inicio_description = var.cloudwatch_inicio_description
  statement_id                  = var.statement_id
  nome_alvo                     = var.nome_alvo
  lambda_function_arn_inicia    = module.lambda_inicia.lambda_function_arn
  lambda_function_name_inicia   = module.lambda_inicia.lambda_function_name_inicia
}

module "cloudwatch_desliga" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-cloudwatch-desliga.git?ref=v1.0.3"
  source                         = "../Modulo-cloudwatch-desliga/"
  cloudwatch_desliga_name        = var.desliga_cloudwatch_desliga_name
  agendamento_cron               = var.desliga_agendamento_cron
  estado                         = var.desliga_estado
  evento_cloudwatch              = var.desliga_evento_cloudwatch
  cloudwatch_desliga_description = var.desliga_cloudwatch_desliga_description
  statement_id                   = var.desliga_statement_id
  nome_alvo                      = var.desliga_nome_alvo
  lambda_function_arn_desliga    = module.lambda_desliga.lambda_function_arn
  lambda_function_name_desliga   = module.lambda_desliga.lambda_function_name_desliga
}

module "Backup" {
  #source = "git@github.com:Victor-Borges-Silva/Modulo-bakcup.git?ref=v1.0.4"
  source                       = "../Modulo-bakcup/"
  nome_cofre                   = var.nome_cofre
  force_destruir               = var.force_destruir
  nome_plano_backup            = var.nome_plano_backup
  nome_regra                   = var.nome_regra
  agendamento_backup           = var.agendamento_backup # agendametno é feito conforme horário UTC +00
  inicio_manutencao            = var.inicio_manutencao  #Especifique(em minutos) o período em que o plano de backup será iniciado, caso não comece no horário especificado.
  janela_manutencao            = var.janela_manutencao  #Defina(em minutos) o período durante o qual o backup deve ser concluído antes de retornar qualquer erro por timeout.
  quantidade_dias_para_delecao = var.quantidade_dias_para_delecao
  nome_selecao_alvo_tag        = var.nome_selecao_alvo_tag
  iam_role_arn_backup          = module.iam_policy_role.iam_role_arn_backup
  selecao_recurso_tag_type     = var.selecao_recurso_tag_type
  selecao_recurso_tag_key      = var.selecao_recurso_tag_key
  selecao_recurso_tag_value    = var.selecao_recurso_tag_value

  depends_on = [module.iam_policy_role]
}
