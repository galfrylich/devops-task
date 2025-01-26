 # Create a VPC
resource "aws_vpc" "vpc-cka-gal" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "vpc-cka-gal"
  }
}


# create IGW
resource "aws_internet_gateway" "cka-igw"{
    vpc_id = aws_vpc.vpc-cka-gal.id
    tags = {
    Name = "igw-gal"
  }
}

resource "aws_subnet" "cka_public_subnets" {
  count                   = length(var.public_subnet_cidr_blocks) # Create one subnet per CIDR block
  vpc_id                  = aws_vpc.vpc-cka-gal.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "cka-publicSubnet-${count.index}"
  }
}


resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.vpc-cka-gal.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${count.index}"
  }
}


# route Tables for public subnet
resource "aws_route_table" "cka_public_rt"{
    vpc_id = aws_vpc.vpc-cka-gal.id
    route {
        cidr_block = var.cidr_block_anywhere
        gateway_id = aws_internet_gateway.cka-igw.id
    }
    tags = {
    Name = "cka-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.cka_public_subnets)
  subnet_id      = aws_subnet.cka_public_subnets[count.index].id
  route_table_id = aws_route_table.cka_public_rt.id
}

# Private Route Table
resource "aws_route_table" "cka-private-rt" {
  vpc_id = aws_vpc.vpc-cka-gal.id
  route {
    cidr_block     = var.cidr_block_anywhere
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "cka-private-rt"
  }
}

resource "aws_route_table_association" "private_subnet_rt" {
  count          = 2
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.cka-private-rt.id
}


#NAT Gateway: 
# Elastic IP for NAT Gateway
resource "aws_eip" "nat_gw" {
  tags = {
    Name = "NatGatewayElasticIp"
  }
}
# Nat gw
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gw.id
  subnet_id     = aws_subnet.cka_public_subnets[0].id
  tags = {
    Name = "nat-gw"
  }
}

# Security Group 
resource "aws_security_group" "cka_public_sg" {
vpc_id      = aws_vpc.vpc-cka-gal.id
# Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port   = var.ports["http"]
    to_port     = var.ports["http"]
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_anywhere]
  }
  ingress {
    from_port   = var.ports["jenkins"]
    to_port     = var.ports["jenkins"]
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_anywhere]
  }
# HTTPS access from anywhere
  ingress {
    from_port   = var.ports["https"]
    to_port     = var.ports["https"]
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_anywhere]
  }
# SSH access from anywhere
  ingress {
    from_port   = var.ports["ssh"]
    to_port     = var.ports["ssh"]
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_anywhere]
  }
  
  
# Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block_anywhere]
  }
  tags = {
    Name = "publicSgcka"
  }
}

resource "aws_security_group" "cka_private_sg" {
  vpc_id = aws_vpc.vpc-cka-gal.id
  ingress {
    from_port   = var.ports["ssh"]
    to_port     = var.ports["ssh"]
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_anywhere]
  }

  
  
  egress {
    from_port   = var.ports["https"]
    to_port     = var.ports["https"]
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_anywhere] # Replace with specific CIDR blocks if needed
  }

  egress {
    from_port   = var.ports["http"]
    to_port     = var.ports["http"]
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_anywhere] # Replace with specific CIDR blocks if needed
  }


  tags = {
    Name = "privateSgCka"
  }
}

