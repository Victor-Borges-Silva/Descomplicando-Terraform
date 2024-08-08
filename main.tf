module "instancias" {
  source        = "git@github.com:Victor-Borges-Silva/Modulo-instancias.git?ref=v1.0.3"
  numero_de_ec2 = 3

  tags = {
    Name        = "Teste"
    Terraform   = "Sim"
    Environment = "Dev"
  }
}


module "iam_policy_role" {
  source = "git@github.com:Victor-Borges-Silva/Modulo-iam.git?ref=v1.0.2"

  #Criação da politica
  policy_name        = "Inicia_Desliga_EC2"
  policy_description = "Policy que permite o Lambda a desligar e ligar as instâncias EC2"

  #Criação da Role
  role_name        = "Inicia_Desliga_EC2"
  role_description = "Função que permite o Lambda a desligar e ligar as instâncias EC2"

}

module "lambda_inicia" {
  #source             = "../../../Modulo-lambda-inicia"
  source             = "git@github.com:Victor-Borges-Silva/Modulo-lambda-inicia.git?ref=v1.0.4"
  nome_funcao_inicia = "IniciaEC2"
  instancia_id       = module.instancias.instance_id
  role               = module.iam_policy_role.iam_role_arn
}

module "lambda_desliga" {
  #source              = "../../../Modulo-lambda-desliga"
  source              = "git@github.com:Victor-Borges-Silva/Modulo-lambda-desliga.git?ref=v1.0.3"
  nome_funcao_desliga = "DesligaEC2"
  instancia_id        = module.instancias.instance_id
  role                = module.iam_policy_role.iam_role_arn

}

module "cloudwatch_inicia" {
  #source                        = "../../../Modulo-cloudwatch-inicia"
  source                        = "git@github.com:Victor-Borges-Silva/Modulo-cloudwatch-inicia.git?ref=v1.0.1"
  cloudwatch_inicia_name        = "Horario_de_inicio"
  cloudwatch_inicio_description = "Agendamento para desligar as instancias"
  aws_region_inicia             = "us-west-1"
  statement_id                  = "permite_EventBridge_executar_lambda_inicia"
  lambda_function_arn_inicia    = module.lambda_inicia.lambda_function_arn
  lambda_function_name_inicia   = module.lambda_inicia.lambda_function_name_inicia
}

module "cloudwatch_desliga" {
  #source                         = "../../../Modulo-cloudwatch-desliga"
  source                         = "git@github.com:Victor-Borges-Silva/Modulo-cloudwatch-desliga.git?ref=v1.0.1"
  cloudwatch_desliga_name        = "Horario_de_desligamento"
  cloudwatch_desliga_description = "Agendamento para desligar as instancias"
  aws_region_desliga             = "us-west-1"
  statement_id                   = "permite_EventBridge_executar_lambda_desliga"
  lambda_function_arn_desliga    = module.lambda_desliga.lambda_function_arn
  lambda_function_name_desliga   = module.lambda_desliga.lambda_function_name_desliga
}