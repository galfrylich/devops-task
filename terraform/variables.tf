variable "vpc_cidr_block" {
   description = "vpc cidr block"
   default = "10.0.0.0/16"
}



variable "cidr_block_anywhere" {
  description = "cidr open to all"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ports" {
  description = "A map of ports with names"
  type        = map(number)
  default = {
    https  = 443
    http  = 80
    ssh = 22
    jenkins = 8080

  }
}

variable "region" {
  description = "region"
  type        = string
}



variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
} 

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for private subnets"
  type        = list(string)
}


variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}


variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}



