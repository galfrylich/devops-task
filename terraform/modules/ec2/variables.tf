

variable "instance_type" {
  description = "instance_type"
  type        = string
  default  = "t2.large"
}


variable "ami" {
  description = "ami for ec2"
  type        = string
  default     = "ami-0819a8650d771b8be"
}


variable "private_subnet_id" {
  description = "private subnet id"
  type        = string
}

variable "private_sg_id" {
  description = "private sg id"
  type        = string
}

variable "key_name" {
  description = "key_name"
  type        = string
}

variable "public_subnet_id" {
  description = "public_subnet_id"
  type        = string
}

variable "public_sg_id" {
  description = "public_sg_id"
  type        = string
}