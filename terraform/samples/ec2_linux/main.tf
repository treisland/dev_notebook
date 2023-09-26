terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17"
    }
  }

  required_version = ">=1.2.0"
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "sg" {
  name        = var.security_group
  vpc_id      = data.aws_vpc.default.id
  description = "this security group will grant SSH access to my ip address"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.sg.id

  cidr_ipv4   = var.allowed_ip
  ip_protocol = "tcp"
  to_port     = 22
  from_port   = 22
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_instance" "instance" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  key_name                    = var.keypair
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  tags = {
    Name = var.instance_name
  }
}

resource "aws_ebs_volume" "data" {
  availability_zone = "us-west-2a"
  size              = 20
  tags = {
    Name = "MyDevVolume"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.instance.id
}