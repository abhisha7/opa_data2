provider "aws" {
    region = "us-west-1"
}

resource "aws_iam_role" "ec2_s3_access_role" {
  name               = "s3-role"
  assume_role_policy = "${file("assumerolepolicy.json")}"
}

#resource "aws_instance" "web" {
#  instance_type = "t2.micro"
# # count = 10
#  ami = "ami-09b4b74c"

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
resource "aws_autoscaling_group" "my_asg2" {
  availability_zones        = ["us-west-2a"]
  name                      = "my_asg2"
  max_size                  = 6
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  launch_configuration      = "my_web_config"
}
resource "aws_autoscaling_group" "my_asg3" {
  availability_zones        = ["us-west-2b"]
  name                      = "my_asg3"
  max_size                  = 7
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  launch_configuration      = "my_web_config"
}


resource "aws_s3_bucket" "demos3" {
    bucket = "opa-test" 
    acl = "private"   
}


#resource "aws_instance" "ec2demo" {
#  ami           = "ami-0533f2ba8a1995cf9" # Amazon Linux in us-east-1, update as per your region
#  instance_type = "t2.micro"
#}
