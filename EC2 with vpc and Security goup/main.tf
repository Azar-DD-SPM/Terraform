#Create_VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my_vpc"
  }
}

#create_security_group
resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = ""
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = ""
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }
  tags = {
    Name = "test_sg"
  }
}

#create ec2 instance

resource "aws_instance" "my_instance" {
  ami                    = ""
  instance_type          = "t2.micro"
  key_name               = "demo"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "My_instance"
  }

}
