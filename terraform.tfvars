# providers values 
profile  = "test"
region   = "us-east-1"

# vpc module values
vpc_cidr = "10.0.0.0/16"

# subnet  module values
pub_subnet = ["10.0.0.0/24","10.0.2.0/24"]

priv_subnet = ["10.0.1.0/24","10.0.3.0/24"]

# loadbalancer  module values
lb_internal = [false,true]
