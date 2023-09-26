
variable "image_id" {
  type        = string
  description = "ami unique id"
}

variable "instance_name" {
  type        = string
  description = "a name to give to the instance"
}

variable "instance_type" {
  type        = string
  description = "the type of instance to use"
  default     = "t2.large"
}

variable "allowed_ip" {
  type        = string
  description = "ip or cidr range that is allowed, example 192.168.0.10 or 192.168.0.10/32"
}

variable "keypair" {
  type        = string
  description = "name of the keypair in aws to use attach to the instance"
}

variable "region" {
  type        = string
  default     = "us-west-2"
  description = "aws deployment region"
}

variable "security_group" {
  type        = string
  description = "the name of the security group to create"
}

variable "volume" {
  type = object({
    availability_zone = string
    size              = number
    name              = string
    device            = string
  })
}
