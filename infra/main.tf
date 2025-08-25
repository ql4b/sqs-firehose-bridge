module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace = local.namespace
  name      = local.name
}

data "aws_caller_identity" "current" {}

locals {
  profile    = var.profile
  region     = var.region
  identity   = data.aws_caller_identity.current
  account_id = local.identity.account_id
  name       = var.name
  namespace  = var.namespace
  id         = module.label.id
  # prefixes
  ssm_prefix = "${"/"}${join("/", compact([
    module.label.namespace != "" ? module.label.namespace : null,
    module.label.name != "" ? module.label.name : null
  ]))}"
  pascal_prefix      = replace(title(module.label.id), "/\\W+/", "")
}

# Public ECR Repository for distribution
resource "aws_ecrpublic_repository" "public" {
  repository_name = module.label.name
  
  catalog_data {
    about_text        = "SQS to Firehose bridge Lambda function using lambda-shell-runtime"
    architectures     = ["ARM 64"]
    description       = "Serverless function that bridges SQS messages to Kinesis Data Firehose using Bash and AWS CLI"
    operating_systems = ["Linux"]
    usage_text        = "docker pull public.ecr.aws/ql4b/sqs-firehose-brige:latest"
  }

  provider = aws.virginia
}