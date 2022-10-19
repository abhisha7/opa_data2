provider "aws" {
    region = "us-west-1"
}

resource "aws_iam_role" "ec2_s3_access_role" {
  name               = "s3-role"
  assume_role_policy = "${file("assumerolepolicy.json")}"
}

resource "aws_instance" "web" {
 instance_type = "t2.micro"
# count = 10
 ami = "ami-09b4b74c"
}
#}
resource "aws_autoscaling_group" "my_asg" {
  availability_zones        = ["us-west-1a"]
  name                      = "my_asg"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  launch_configuration      = "my_web_config"
}
resource "aws_launch_configuration" "my_web_config" {
    name = "my_web_config"
    image_id = "ami-09b4b74c"
    instance_type = "t2.micro"
}
# resource "aws_autoscaling_group" "my_asg2" {
#   availability_zones        = ["us-west-2a"]
#   name                      = "my_asg2"
#   max_size                  = 6
#   min_size                  = 1
#   health_check_grace_period = 300
#   health_check_type         = "ELB"
#   desired_capacity          = 4
#   force_delete              = true
#   launch_configuration      = "my_web_config"
# }
# resource "aws_autoscaling_group" "my_asg3" {
#   availability_zones        = ["us-west-2b"]
#   name                      = "my_asg3"
#   max_size                  = 7
#   min_size                  = 1
#   health_check_grace_period = 300
#   health_check_type         = "ELB"
#   desired_capacity          = 4
#   force_delete              = true
#   launch_configuration      = "my_web_config"
# }


resource "aws_s3_bucket" "demos3" {
    bucket = "opa-test" 
    acl = "private"   
}

resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  vpc      = true
}

resource "aws_security_group" "demo-sg" {
  name = "sec-grp"
  description = "Allow HTTP and SSH traffic via Terraform"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
