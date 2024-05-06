# CREATE 2 TARGET GROUP FOR PUBLIC AND PRIVATE SUBNETS
resource "aws_lb_target_group" "tg" {
    port     = 80
    protocol = "HTTP"   
    vpc_id   = var.lb_vpc_id
}


# ATTACHE TARGET GROUP TO PUBLIC SUBNETS


resource "aws_lb_target_group_attachment" "public-target-group-attachment" {
    count             = length(var.target_id)
    target_group_arn  = aws_lb_target_group.tg.arn
    target_id         = var.target_id[count.index]
    port              = 80
}



# CREATE PUBLIC & PRIVATE LOAD BALANCER 

resource "aws_lb" "load-balancer" {
    name                     = var.name_lb
    internal                 = var.lb_internal
    load_balancer_type       = "application"
    subnets                  = var.lb_subnets  
    security_groups          = var.lb_sg_id
    # enable_deletion_protection = true
}


# CREATE LOAD BALANCER LISTNERS

resource "aws_lb_listener" "lb-listner" {

    load_balancer_arn   = aws_lb.load-balancer.id
    port                = "80"
    protocol            = "HTTP"
    default_action {
        type  = "forward"
        target_group_arn = aws_lb_target_group.tg.id
  }
}
