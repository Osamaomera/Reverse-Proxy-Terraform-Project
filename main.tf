provider "aws" {
  profile = var.profile
  region  = var.region
}

module "vpc"{
  source        = "./modules/vpc"
  vpc_cidr      = var.vpc_cidr
  nat_subnet_id = module.subnets.public_subnets_id[0]
}

module "subnets"{ 
  source       = "./modules/subnets"
  vpc_id       = module.vpc.vpc_id
  subnet_count = var.subnet_count
  pub_subnets  = var.pub_subnet
  priv_subnets = var.priv_subnet
  igw_id       = module.vpc.igw_id
  nat_id       = module.vpc.nat_id
}


module "ec2-private" {

    source                  = "./modules/ec2"
    vpc_id                  = module.vpc.vpc_id
    count                   = var.subnet_count
    key_name                = "ec2"
    subnet_id               = module.subnets.private_subnets_id[count.index]
    depends_on              = [ module.vpc ]
    instance_tags           = {Name = "Private_${count.index + 1}"}  
    user_data               = file("user_data_apache2.sh")

}

module "ec2-public" {
    source                  = "./modules/ec2"
    vpc_id                  = module.vpc.vpc_id
    count                   = var.subnet_count
    subnet_id               = module.subnets.public_subnets_id[count.index]
    key_name                = "ec2"
    depends_on              = [module.vpc ]
    instance_tags           = {Name = "Public_${count.index + 1}"} 
    user_data               = file("user_data_proxy.sh") 
}

locals {
  list_of_priv = [for instance in module.ec2-private : instance.id]
  list_of_pub = [for instance in module.ec2-public : instance.id]
}



module "Private_load_balancer" {
   
    source = "./modules/loadbalancer"
    name_lb = "private-LB"
    lb_vpc_id = module.vpc.vpc_id
    target_id = local.list_of_priv
    lb_internal = true
    lb_subnets  = module.subnets.private_subnets_id
    lb_sg_id  =  [for instance in module.ec2-private : instance.security_group_id]
    
}

module "Public_load_balancer" {
   
    source = "./modules/loadbalancer"
    name_lb = "public-LB"
    lb_vpc_id = module.vpc.vpc_id
    target_id = local.list_of_pub
    lb_internal = false
    lb_subnets  = module.subnets.public_subnets_id
    lb_sg_id  =  [for instance in module.ec2-public : instance.security_group_id]
    
    
}


# OUTPUT TO RETRIVE THE  LOAD BALANCER DNS
output "Public_load_balancer_dns" {
  value = module.Public_load_balancer.load_balancer_dns

} 
output "Private_load_balancer_dns" {
  value = module.Private_load_balancer.load_balancer_dns
  
} 