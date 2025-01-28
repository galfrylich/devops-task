variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "private_subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 5
}

variable "instance_types" {
  description = "Instance types for worker nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "ami_type" {
  description = "AMI type for worker nodes"
  type        = string
  default     = "AL2_x86_64"
}

variable "endpoint_private_access" {
  description = "Whether the EKS API server endpoint is private"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Whether the EKS API server endpoint is public"
  type        = bool
  default     = true
}

variable "enabled_cluster_log_types" {
  description = "EKS cluster logging types"
  type        = list(string)
  default     = ["api", "audit", "authenticator"]
}

variable "default_tags" {
  description = "Default tags for resources"
  type        = map(string)
  default     = {}
}
variable "vpc_id" {
  description = "vpc_id"
  type        = string
}

variable "jenkins_ip" {
  description = "jenkins_ip"
  type        = string
}

