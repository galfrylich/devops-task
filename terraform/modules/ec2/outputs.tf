output "jenkins_ip" {
    description = "jenkins public ip "
    value = aws_instance.jenkins-ec2.public_ip 
}

