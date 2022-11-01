resource "aws_instance" "web" {
  ami                         = var.amis
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = [aws_security_group.allow_all.id]
  tags = {
    Name = "Server-1"
  }
  user_data = <<EOF
#!/bin/bash
apt update -y
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD5OhnKc2fB0dnWlZZMokI/0BZ5ekEKogM4gceb5oyN4xa3ggTadm1j2ZsC0pmMVuc+8+0A8cfklZKX47WjEIHv421Ps2B2DyG4nNY9Sl+M9hvannGlf0gtu1x6SYcLjPa4hCp7bLYw6hRw8EsG9zqaruGXwzunboTBWk4C6dIDS8azd+W0iLa+9rZ/Pl0ntg548dOHceN+H1jLMW4sSS91JvbbgA+3VvNFK77sIGuLT4NiyeQn4rYaf0ZFZ/wC63JVvGB56bYY49nIV26nig9MF9cihahg0OCThp3+4kGvKDbIK9Tlx5prNAuq+q2JTgoFMZsz3V9RAavI03aRwDBdNfWXlpSYTFiOG4PcXpK1McNfi8drwY+nZxp2ZhYZWQLXKCwRZRcDSNq6GgQNam7Z/2ePSa2O+0Jw07pcsQhSPGZJmiZC87c4Dgykunwc9UYfo4YNNfSux6jIvdtTiWTRSoinA1fEhmmOPR54+ThieW8hk04us7F2oX/VZlnkdCU= jenkins@ip-172-31-41-108' >> /home/ubuntu/.ssh/authorized_keys
EOF
}
resource "time_sleep" "wait_30_seconds" {
  depends_on = [aws_instance.web]
  create_duration = "30s"
}
