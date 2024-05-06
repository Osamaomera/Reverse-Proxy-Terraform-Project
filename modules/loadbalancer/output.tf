# OUTPUT TO RETRIVE THE LOAD BALANCER DNS
output "load_balancer_dns" {
  value = aws_lb.load-balancer.dns_name
} 
