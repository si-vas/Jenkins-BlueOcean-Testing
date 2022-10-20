# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("hosts.tpl",
    {
      server-1 = aws_instance.web.public_ip
    }
  )
  filename = "hosts.cfg"
}
