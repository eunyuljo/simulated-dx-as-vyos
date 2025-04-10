

# ────────────────────────────────────────────
# vpc1 VPC (10.0.0.0/16)
# ────────────────────────────────────────────
resource "aws_vpc" "vpc1_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc1-VPC"
  }
}

resource "aws_subnet" "vpc1_public_subnet" {
  vpc_id                  = aws_vpc.vpc1_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2a"
  tags = {
    Name = "vpc1-Public-Subnet"
  }
}

resource "aws_subnet" "vpc1_2_public_subnet" {
  vpc_id                  = aws_vpc.vpc1_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2a"
  tags = {
    Name = "vpc1_2-Public-Subnet"
  }
}

resource "aws_subnet" "vpc1_private_subnet" {
  vpc_id                  = aws_vpc.vpc1_vpc.id
  cidr_block              = "10.0.100.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false

  tags = {
    Name = "vpc1-Private-Subnet"
  }
}

resource "aws_internet_gateway" "vpc1_igw" {
  vpc_id = aws_vpc.vpc1_vpc.id
  tags = {
    Name = "vpc1-IGW"
  }
}

resource "aws_route_table" "vpc1_public_rt" {
  vpc_id = aws_vpc.vpc1_vpc.id
  tags = {
    Name = "vpc1-Public-RouteTable"
  }
}

resource "aws_route_table" "vpc1_private_rt" {
  vpc_id = aws_vpc.vpc1_vpc.id

  tags = {
    Name = "vpc1-Private-RouteTable"
  }
}

resource "aws_route" "vpc1_default_route" {
  route_table_id         = aws_route_table.vpc1_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc1_igw.id
}


resource "aws_route_table_association" "vpc1_public_assoc" {
  subnet_id      = aws_subnet.vpc1_public_subnet.id
  route_table_id = aws_route_table.vpc1_public_rt.id
}

resource "aws_route_table_association" "vpc1_2_public_assoc" {
  subnet_id      = aws_subnet.vpc1_2_public_subnet.id
  route_table_id = aws_route_table.vpc1_public_rt.id
}

resource "aws_route_table_association" "vpc1_private_assoc" {
  subnet_id      = aws_subnet.vpc1_private_subnet.id
  route_table_id = aws_route_table.vpc1_private_rt.id
}



