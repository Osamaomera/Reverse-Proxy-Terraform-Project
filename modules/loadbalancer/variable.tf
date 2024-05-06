# VARIABLES NEEDED IN TARGET GROUPS
variable "lb_vpc_id"{
    type = string
}
# VARIABLES NEEDED IN TARGET GROUP ATTACHMENT
variable "target_id"{
    type = list(string)
}
variable "name_lb" {
    type = string
}
# VARIABLES NEEDED IN LOAD BALANCER
variable "lb_internal"{
    type = bool
}

# list of [list of public subnets , list of private subnets]
variable "lb_subnets"{
    type = list(string)
}

variable "lb_sg_id"{
    type = list(string)
}
