output env {
    value = {
        profile = local.profile
        region = local.region
        namespace = module.label.namespace
        name = module.label.name
        id = module.label.id
        account_id = local.account_id
    }
}

output "public_ecr" {
  description = "Public ECR repository details"
  value = {
    repository_uri = aws_ecrpublic_repository.public.repository_uri
    registry_id    = aws_ecrpublic_repository.public.registry_id
  }
}