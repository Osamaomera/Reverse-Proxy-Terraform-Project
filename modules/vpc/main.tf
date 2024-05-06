# Creation of vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = { 
    Name = "NTI-VPC"
  }
}

# Creation pf internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "NTI-IGW"
  }
}

# Creation of ELASTIC IP
resource "aws_eip" "eip" {
  domain   = "vpc"
}

# Creation of nat in the first public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.nat_subnet_id
  tags = {
    Name = "NTI-NAT"
  }
  # To ensure proper ordering, i will add an explicit dependency on the Internet Gateway.
  depends_on = [aws_internet_gateway.igw]
}
