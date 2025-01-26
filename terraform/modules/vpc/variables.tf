variable "vpc_cidr_block" {
   description = "vpc cidr block"
}


variable "cidr_block_anywhere" {
  description = "cidr open to all"
  type        = string
}


variable "ports" {
  description = "A map of ports with names"
  type        = map(number)
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

