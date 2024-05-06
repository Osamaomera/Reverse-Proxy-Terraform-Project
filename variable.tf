# providers variables 
variable "profile" {}
variable "region" {}

# vpc module  variables
variable "vpc_cidr"{}

variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
  default     = 2 
}

# subnet module variables
variable "pub_subnet"{
    type  = list(string)
}

variable "priv_subnet"{
    type  = list(string)
}

# loadbalancer module variables
variable "lb_internal"{
  default = false
}
