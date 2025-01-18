# terraform-aws-Victor-Borges-Silva_iac
Repositório destinado ao projeto final. 

# Repositório auxiliar para checagem de segurança
https://github.com/aquasecurity/tfsec

# Repositório auxiliar para criação do README
https://github.com/terraform-docs/terraform-docs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.58.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_Backup"></a> [Backup](#module\_Backup) | ../Modulo-bakcup/ | n/a |
| <a name="module_cloudwatch_desliga"></a> [cloudwatch\_desliga](#module\_cloudwatch\_desliga) | ../Modulo-cloudwatch-desliga/ | n/a |
| <a name="module_cloudwatch_inicia"></a> [cloudwatch\_inicia](#module\_cloudwatch\_inicia) | ../Modulo-cloudwatch-inicia/ | n/a |
| <a name="module_iam_policy_role"></a> [iam\_policy\_role](#module\_iam\_policy\_role) | ../Modulo-iam/ | n/a |
| <a name="module_instancias"></a> [instancias](#module\_instancias) | ../Modulo-instancias/ | n/a |
| <a name="module_lambda_desliga"></a> [lambda\_desliga](#module\_lambda\_desliga) | ../Modulo-lambda-desliga/ | n/a |
| <a name="module_lambda_inicia"></a> [lambda\_inicia](#module\_lambda\_inicia) | ../Modulo-lambda-inicia/ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agendamento_backup"></a> [agendamento\_backup](#input\_agendamento\_backup) | Agendamento do backup | `string` | n/a | yes |
| <a name="input_agendamento_cron"></a> [agendamento\_cron](#input\_agendamento\_cron) | Agendamento em formato cron para iniciar a função | `string` | n/a | yes |
| <a name="input_armazenamento_temporario"></a> [armazenamento\_temporario](#input\_armazenamento\_temporario) | description | `number` | n/a | yes |
| <a name="input_cloudwatch_inicia_name"></a> [cloudwatch\_inicia\_name](#input\_cloudwatch\_inicia\_name) | Nome do CloudWatch Inicia | `string` | n/a | yes |
| <a name="input_cloudwatch_inicio_description"></a> [cloudwatch\_inicio\_description](#input\_cloudwatch\_inicio\_description) | Descrição para o início do CloudWatch | `string` | n/a | yes |
| <a name="input_description_role_backup"></a> [description\_role\_backup](#input\_description\_role\_backup) | Descrição para função IAM que permite o cofre gerenciar os backups | `string` | n/a | yes |
| <a name="input_desliga_agendamento_cron"></a> [desliga\_agendamento\_cron](#input\_desliga\_agendamento\_cron) | Agendamento em formato cron para desligar a função | `string` | n/a | yes |
| <a name="input_desliga_cloudwatch_desliga_description"></a> [desliga\_cloudwatch\_desliga\_description](#input\_desliga\_cloudwatch\_desliga\_description) | Descrição para o desligamento no CloudWatch | `string` | n/a | yes |
| <a name="input_desliga_cloudwatch_desliga_name"></a> [desliga\_cloudwatch\_desliga\_name](#input\_desliga\_cloudwatch\_desliga\_name) | Nome do CloudWatch para Desligar | `string` | n/a | yes |
| <a name="input_desliga_estado"></a> [desliga\_estado](#input\_desliga\_estado) | Estado da instância ou recurso no processo de desligamento | `string` | n/a | yes |
| <a name="input_desliga_evento_cloudwatch"></a> [desliga\_evento\_cloudwatch](#input\_desliga\_evento\_cloudwatch) | Descrição do evento do CloudWatch para desligamento | `string` | n/a | yes |
| <a name="input_desliga_nome_alvo"></a> [desliga\_nome\_alvo](#input\_desliga\_nome\_alvo) | Nome do alvo da função ou evento de desligamento | `string` | n/a | yes |
| <a name="input_desliga_statement_id"></a> [desliga\_statement\_id](#input\_desliga\_statement\_id) | ID do statement para a política de desligamento | `string` | n/a | yes |
| <a name="input_estado"></a> [estado](#input\_estado) | Estado da instância ou recurso | `string` | n/a | yes |
| <a name="input_evento_cloudwatch"></a> [evento\_cloudwatch](#input\_evento\_cloudwatch) | Descrição do evento do CloudWatch | `string` | n/a | yes |
| <a name="input_force_destruir"></a> [force\_destruir](#input\_force\_destruir) | Flag para forçar a destruição | `bool` | n/a | yes |
| <a name="input_inicio_manutencao"></a> [inicio\_manutencao](#input\_inicio\_manutencao) | Data e hora de início da manutenção | `number` | n/a | yes |
| <a name="input_janela_manutencao"></a> [janela\_manutencao](#input\_janela\_manutencao) | Janela de tempo para a manutenção | `number` | n/a | yes |
| <a name="input_nome_alvo"></a> [nome\_alvo](#input\_nome\_alvo) | Nome do alvo da função ou evento | `string` | n/a | yes |
| <a name="input_nome_cofre"></a> [nome\_cofre](#input\_nome\_cofre) | Nome do Cofre | `string` | n/a | yes |
| <a name="input_nome_funcao_desliga"></a> [nome\_funcao\_desliga](#input\_nome\_funcao\_desliga) | description | `string` | n/a | yes |
| <a name="input_nome_funcao_inicia"></a> [nome\_funcao\_inicia](#input\_nome\_funcao\_inicia) | description | `string` | n/a | yes |
| <a name="input_nome_plano_backup"></a> [nome\_plano\_backup](#input\_nome\_plano\_backup) | Nome do plano de backup | `string` | n/a | yes |
| <a name="input_nome_regra"></a> [nome\_regra](#input\_nome\_regra) | Nome da regra | `string` | n/a | yes |
| <a name="input_nome_role_backup"></a> [nome\_role\_backup](#input\_nome\_role\_backup) | Nome da role/função para permitir o AWSBackup gerenciar os pontos de restauração | `string` | n/a | yes |
| <a name="input_nome_selecao_alvo_tag"></a> [nome\_selecao\_alvo\_tag](#input\_nome\_selecao\_alvo\_tag) | Nome da tag do alvo de seleção | `string` | n/a | yes |
| <a name="input_numero_de_ec2"></a> [numero\_de\_ec2](#input\_numero\_de\_ec2) | Quantidade de instancias EC2 a ser provisionada | `number` | n/a | yes |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | description | `string` | n/a | yes |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Nome da politica | `string` | n/a | yes |
| <a name="input_quantidade_dias_para_delecao"></a> [quantidade\_dias\_para\_delecao](#input\_quantidade\_dias\_para\_delecao) | Quantidade de dias para a deleção | `number` | n/a | yes |
| <a name="input_rastreio_log"></a> [rastreio\_log](#input\_rastreio\_log) | description | `string` | n/a | yes |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | Nome da role | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Nome da Funcao | `string` | n/a | yes |
| <a name="input_selecao_recurso_tag_key"></a> [selecao\_recurso\_tag\_key](#input\_selecao\_recurso\_tag\_key) | Chave da tag para seleção de recurso | `string` | n/a | yes |
| <a name="input_selecao_recurso_tag_type"></a> [selecao\_recurso\_tag\_type](#input\_selecao\_recurso\_tag\_type) | Tipo da tag para seleção de recurso | `string` | n/a | yes |
| <a name="input_selecao_recurso_tag_value"></a> [selecao\_recurso\_tag\_value](#input\_selecao\_recurso\_tag\_value) | Valor da tag para seleção de recurso | `string` | n/a | yes |
| <a name="input_statement_id"></a> [statement\_id](#input\_statement\_id) | ID do statement para a política | `string` | n/a | yes |
| <a name="input_tamanho_memoria"></a> [tamanho\_memoria](#input\_tamanho\_memoria) | description | `number` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | description | `number` | n/a | yes |
| <a name="input_tipo_instancia"></a> [tipo\_instancia](#input\_tipo\_instancia) | Tipo de instancia EC2 a ser provisionada | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->