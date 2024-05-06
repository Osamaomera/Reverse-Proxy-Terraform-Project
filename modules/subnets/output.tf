# Output to Retrive all Private Subnets id
output "public_subnets_id" {
    value = aws_subnet.public_subnets[*].id
}

# Output to Retrive all Public Subnets id
output "private_subnets_id" {
    value = aws_subnet.private_subnets[*].id
}
