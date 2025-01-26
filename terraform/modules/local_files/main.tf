data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.tpl")

  vars = {
    jenkins_ip    = var.jenkins_ip
    current_dir = path.cwd
  }
}

resource "local_file" "ansible_inventory" {
  content  = data.template_file.ansible_inventory.rendered
  filename = "${path.cwd}/../ansible/inventory.ini"
}
