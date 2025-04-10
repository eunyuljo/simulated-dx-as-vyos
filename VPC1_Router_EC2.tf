

resource "aws_security_group" "vpc1_sg" {
  vpc_id = aws_vpc.vpc1_vpc.id
  name   = "vpc1-SG"

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
    Name = "vpc1SecurityGroup"
  }
}


# EIP 연결 (이제 interface_id는 고정됨)
resource "aws_eip" "vpc1_eip" {
  network_interface = aws_network_interface.vpc1_eni.id
  depends_on        = [aws_internet_gateway.vpc1_igw]

  tags = {
    Name = "vpc1-Router"
  }
}



# ENI 생성
resource "aws_network_interface" "vpc1_eni" {
  subnet_id         = aws_subnet.vpc1_public_subnet.id
  security_groups   = [aws_security_group.vpc1_sg.id]
  source_dest_check = false

  tags = {
    Name = "vpc1-ENI"
  }
}

# 추가 인터페이스 
# 추가 EIP - 보조 인터페이스에 연결 
resource "aws_eip" "vpc1_2_eip_secondary" {
  network_interface = aws_network_interface.vpc1_2_eni_secondary.id
  depends_on        = [aws_internet_gateway.vpc1_igw]

  tags = {
    Name = "vpc1_2-Router-Secondary"
  }
}
resource "aws_network_interface" "vpc1_2_eni_secondary" {
  subnet_id         = aws_subnet.vpc1_2_public_subnet.id
  security_groups   = [aws_security_group.vpc1_sg.id]
  source_dest_check = false
  tags = {
    Name = "vpc1_2-ENI-Secondary"
  }
}

resource "aws_network_interface_attachment" "vpc1_attach_secondary" {
  instance_id          = aws_instance.vpc1.id
  network_interface_id = aws_network_interface.vpc1_2_eni_secondary.id
  device_index         = 1
}



# EC2 인스턴스에 ENI를 연결
resource "aws_instance" "vpc1" {
  ami                         = "ami-02f26353a98d466a5"
  instance_type               = "t3.medium"
  key_name                    = "fnf-test"
  
  network_interface {
    network_interface_id = aws_network_interface.vpc1_eni.id
    device_index         = 0
  }

  tags = {
    Name = "vpc1-Router"
  }
}