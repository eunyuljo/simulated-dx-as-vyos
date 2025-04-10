

resource "aws_security_group" "vpc2_sg" {
  vpc_id = aws_vpc.vpc2_vpc.id
  name   = "vpc2-SG"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4500
    to_port     = 4500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 500
    to_port     = 500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc2SecurityGroup"
  }
}


# EIP 연결 (이제 interface_id는 고정됨)
resource "aws_eip" "vpc2_eip" {
  network_interface = aws_network_interface.vpc2_eni.id
  depends_on        = [aws_internet_gateway.vpc2_igw]

  tags = {
    Name = "vpc2-Router"
  }
}

# ENI 생성
resource "aws_network_interface" "vpc2_eni" {
  subnet_id         = aws_subnet.vpc2_public_subnet.id
  security_groups   = [aws_security_group.vpc2_sg.id]
  source_dest_check = false

  tags = {
    Name = "vpc2-ENI"
  }
}

# EC2 인스턴스에 ENI를 연결
resource "aws_instance" "vpc2" {
  ami                         = "ami-02f26353a98d466a5"
  instance_type               = "t3.medium"
  key_name                    = "fnf-test"
  
  network_interface {
    network_interface_id = aws_network_interface.vpc2_eni.id
    device_index         = 0
  }

  tags = {
    Name = "vpc2-Router"
  }
}