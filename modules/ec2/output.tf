# OUTPUT TO RETRIVE ALL INSTANCES IP
output "id" {
  description = "The ID of the instance"
  value =aws_instance.ec2.id
}


# OUTPUT TO RETRIVE SECURITY GROUP ID TO BE USED IN LOAD BALANCER 
output "security_group_id" {
    value = aws_security_group.sg.id
}
