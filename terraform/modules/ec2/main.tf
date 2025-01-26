# Creating EC2 instance in artifactory Subnet
resource "aws_instance" "jenkins-ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [ var.public_sg_id ]
  subnet_id = var.public_subnet_id
  associate_public_ip_address = true
  key_name = var.key_name
  tags = {
    Name = "jenkins-ec2"
  }
}