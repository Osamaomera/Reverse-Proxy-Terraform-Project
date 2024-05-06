variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
  default     = 2 
}

variable "vpc_id"{
    description = "ID of the vpc in where the subnets will be"
    type        = string
}

variable "pub_subnets" {
    description = "public subnets info"
    type = list(string)
}

variable "priv_subnets" {
    description = "private subnets info"
    type = list(string)
}

variable "igw_id"{
    description = "ID of the IGW to be used in route table for public subnets"
    type = string
}

variable "nat_id"{
    description = "ID of the NAT to be used in route table for private subnets"
    type = string
}
