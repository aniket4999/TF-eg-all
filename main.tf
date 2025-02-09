
/*
resource "aws_security_group" "testSG" {
  name        = "example"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Demo-SG"
  }
}

*/

resource "aws_instance" "createEC2" {
    ami = var.ami_value
    instance_type = var.instancetype
#    security_groups = [aws_security_group.testSG.name]

    tags = {
        name = "Demo"
    }  
}
