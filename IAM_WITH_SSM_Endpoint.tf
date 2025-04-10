# #####################################################################################

# # SSM 세션 매니저 연결을 위한 IAM 역할 생성
# resource "aws_iam_role" "ssm_role" {
#   name = "vpc1-SSMRole"
  
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
  
#   tags = {
#     Name = "vpc1-SSMRole"
#   }
# }


# # SSM 매니지드 정책 연결
# resource "aws_iam_role_policy_attachment" "ssm_policy" {
#   role       = aws_iam_role.ssm_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }

# # 인스턴스 프로파일 생성
# resource "aws_iam_instance_profile" "ssm_instance_profile" {
#   name = "SSMInstanceProfile"
#   role = aws_iam_role.ssm_role.name
# }


# ####################################################################################################


# resource "aws_security_group" "vpc1_endpoint_sg" {
#   vpc_id = aws_vpc.vpc1_vpc.id
#   name   = "vpc1-endpoint-SG"
  
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [aws_vpc.vpc1_vpc.cidr_block]
#   }
  
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
  
#   tags = {
#     Name = "vpc1-endpoint-SecurityGroup"
#   }
# }

# # SSM 세션 매니저를 위한 VPC 엔드포인트 생성
# resource "aws_vpc_endpoint" "ssm" {
#   vpc_id            = aws_vpc.vpc1_vpc.id
#   service_name      = "com.amazonaws.ap-northeast-2.ssm"
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = [aws_subnet.vpc1_private_subnet.id]
#   security_group_ids = [aws_security_group.vpc1_endpoint_sg.id]
#   private_dns_enabled = true
  
#   tags = {
#     Name = "vpc1-SSM-Endpoint"
#   }
# }

# resource "aws_vpc_endpoint" "ssm_messages" {
#   vpc_id            = aws_vpc.vpc1_vpc.id
#   service_name      = "com.amazonaws.ap-northeast-2.ssmmessages"
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = [aws_subnet.vpc1_private_subnet.id]
#   security_group_ids = [aws_security_group.vpc1_endpoint_sg.id]
#   private_dns_enabled = true
  
#   tags = {
#     Name = "vpc1-SSMMessages-Endpoint"
#   }
# }

# resource "aws_vpc_endpoint" "ec2_messages" {
#   vpc_id            = aws_vpc.vpc1_vpc.id
#   service_name      = "com.amazonaws.ap-northeast-2.ec2messages"
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = [aws_subnet.vpc1_private_subnet.id]
#   security_group_ids = [aws_security_group.vpc1_endpoint_sg.id]
#   private_dns_enabled = true
  
#   tags = {
#     Name = "vpc1-EC2Messages-Endpoint"
#   }
# }

# ####################################################################################

# resource "aws_security_group" "vpc2_endpoint_sg" {
#   vpc_id = aws_vpc.vpc2_vpc.id
#   name   = "vpc1-endpoint-SG"
  
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [aws_vpc.vpc2_vpc.cidr_block]
#   }
  
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
  
#   tags = {
#     Name = "vpc2-endpoint-SecurityGroup"
#   }
# }

# # SSM 세션 매니저를 위한 VPC 엔드포인트 생성
# resource "aws_vpc_endpoint" "ssm2" {
#   vpc_id            = aws_vpc.vpc2_vpc.id
#   service_name      = "com.amazonaws.ap-northeast-2.ssm"
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = [aws_subnet.vpc2_private_subnet.id]
#   security_group_ids = [aws_security_group.vpc2_endpoint_sg.id]
#   private_dns_enabled = true
  
#   tags = {
#     Name = "vpc1-SSM-Endpoint"
#   }
# }

# resource "aws_vpc_endpoint" "ssm_messages2" {
#   vpc_id            = aws_vpc.vpc2_vpc.id
#   service_name      = "com.amazonaws.ap-northeast-2.ssmmessages"
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = [aws_subnet.vpc2_private_subnet.id]
#   security_group_ids = [aws_security_group.vpc2_endpoint_sg.id]
#   private_dns_enabled = true
  
#   tags = {
#     Name = "vpc1-SSMMessages-Endpoint"
#   }
# }

# resource "aws_vpc_endpoint" "ec2_messages2" {
#   vpc_id            = aws_vpc.vpc2_vpc.id
#   service_name      = "com.amazonaws.ap-northeast-2.ec2messages"
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = [aws_subnet.vpc2_private_subnet.id]
#   security_group_ids = [aws_security_group.vpc2_endpoint_sg.id]
#   private_dns_enabled = true
  
#   tags = {
#     Name = "vpc1-EC2Messages-Endpoint"
#   }
# }