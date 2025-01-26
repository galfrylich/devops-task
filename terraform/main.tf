module "vpc" {
    source      = "./modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
    private_subnet_cidrs = var.private_subnet_cidrs
    cidr_block_anywhere = var.cidr_block_anywhere
    ports = var.ports
    availability_zones = var.availability_zones
}

module "ec2" {
    source = "./modules/ec2"
    private_sg_id = module.vpc.private_sg_id
    private_subnet_id = module.vpc.private_subnet_ids[0]
    public_subnet_id = module.vpc.public_subnet_ids[0]
    public_sg_id = module.vpc.public_sg_id
    key_name = module.security.key_name
}

module "security" {
  source = "./modules/security"
}

module "local_files" {
  source = "./modules/local_files"
  jenkins_ip = module.ec2.jenkins_ip
}


module "eks" {
  source = "./modules/eks"
  vpc_id = module.vpc.vpc_id
  cluster_name  = var.cluster_name
  private_subnet_ids    = module.vpc.private_subnet_ids
  environment   = var.environment
  project_name  = var.project_name
  jenkins_ip = module.ec2.jenkins_ip
  default_tags = {
    Owner = "DevOps Team"
    CostCenter = "12345"
  }
}