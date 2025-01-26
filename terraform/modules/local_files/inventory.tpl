
[jenkins-host]
jenkins ansible_host=${jenkins_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${current_dir}/../ansible/key_pair.pem name=jenkins-host

