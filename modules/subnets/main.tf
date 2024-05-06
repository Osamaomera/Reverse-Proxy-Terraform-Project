# Availability Zones
data "aws_availability_zones" "available" {}


# first with public subnets 

# Creation of public subnets

resource "aws_subnet" "public_subnets" {
  count             = var.subnet_count
  vpc_id            = var.vpc_id
  cidr_block        = var.pub_subnets[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "NTI-public-subnet-${count.index + 1}"
  }
}

# Creation of public route table

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "route-public-table"
  }
}

# Assign the public route table to all public subnets

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
 }

 
 # second with private subnets 
 
 # Creation of private subnets

resource "aws_subnet" "private_subnets" {
  count             = var.subnet_count
  vpc_id            = var.vpc_id
  cidr_block        = var.priv_subnets[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "NTI-private-subnet-${count.index + 1}"
  }
}
# Creation of private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
    tags = {
    Name = "route-private-table"
  }
}
# Assign the private route table to all private subnets
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
 }
