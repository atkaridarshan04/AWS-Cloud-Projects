output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.web.public_dns
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "ecr_repository_name" {
  value = aws_ecr_repository.app.name
}

output "ec2_iam_role_name" {
  value = aws_iam_role.ec2_role.name
}

output "ssh_private_key" {
  value     = tls_private_key.deployer.private_key_pem
  sensitive = true
}
