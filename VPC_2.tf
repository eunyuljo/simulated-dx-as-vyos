

# ────────────────────────────────────────────
# vpc2 VPC (10.1.0.0/16)
# ────────────────────────────────────────────
resource "aws_vpc" "vpc2_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc2-VPC"
  }
}

resource "aws_subnet" "vpc2_public_subnet" {
  vpc_id                  = aws_vpc.vpc2_vpc.id
  cidr_block              = "10.1.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2a"
  tags = {
    Name = "vpc2-Public-Subnet"
  }
}

resource "aws_subnet" "vpc2_2_public_subnet" {
  vpc_id                  = aws_vpc.vpc2_vpc.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2a"
  tags = {
    Name = "vpc2_2-Public-Subnet"
  }
}

resource "aws_subnet" "vpc2_private_subnet" {
  vpc_id                  = aws_vpc.vpc2_vpc.id
  cidr_block              = "10.1.100.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false

  tags = {
    Name = "vpc2-Private-Subnet"
  }
}


resource "aws_internet_gateway" "vpc2_igw" {
  vpc_id = aws_vpc.vpc2_vpc.id
  tags = {
    Name = "vpc2-IGW"
  }
}

resource "aws_route_table" "vpc2_public_rt" {
  vpc_id = aws_vpc.vpc2_vpc.id
  tags = {
    Name = "vpc2-Public-RouteTable"
  }
}

resource "aws_route_table" "vpc2_private_rt" {
  vpc_id = aws_vpc.vpc2_vpc.id

  tags = {
    Name = "vpc2-Private-RouteTable"
  }
}

resource "aws_route" "vpc2_default_route" {
  route_table_id         = aws_route_table.vpc2_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc2_igw.id
}


resource "aws_route_table_association" "vpc2_public_assoc" {
  subnet_id      = aws_subnet.vpc2_public_subnet.id
  route_table_id = aws_route_table.vpc2_public_rt.id
}

resource "aws_route_table_association" "vpc2_2_public_assoc" {
  subnet_id      = aws_subnet.vpc2_2_public_subnet.id
  route_table_id = aws_route_table.vpc2_public_rt.id
}

resource "aws_route_table_association" "vpc2_private_assoc" {
  subnet_id      = aws_subnet.vpc2_private_subnet.id
  route_table_id = aws_route_table.vpc2_private_rt.id
}

