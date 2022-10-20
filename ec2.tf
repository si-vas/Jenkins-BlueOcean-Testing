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
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5Ar8YsSFS0uSDcvmcKPWFQJgZ5pXZbxs+p+k4VTsFiTQ1VDakjWPYxyPcH33Ejxigfgo65YICO9jBxGXUppeHRKQQLOH3vsiqNrGCdG6DajnBqROkWg3eiQAuLL9t8185tRndgeouTS3cc/uXVUsYYKu2TG0N6wcsYO20dkVg8cI3xKgIfpbO5Ufh6gMqFbFjxttmJOaXmYD5P0vkqJXmfUMJnJ8uxqRo1OyoBWL/+nlgmBxf6baFZPPk5mgmdDRL13X1R2LE89Jyptw1mTcSfF1nYjSUTM+PvTAJllUSW+9qsa5S1Q2eN9kBgsJRVDZq8uTnV2NkyiZyP1/02LN/uSpCQrK/BeZ/3HcBifQjPs1iyk0Hs6OzzYwGcwgCMZcg8b1mdFgXTFnjC1TwJi+HQGUphcTpKSCm4u8WlBOeIx8ZWZAEGxYqyDSJZKg1gpNnorYW8Ip6PKk1ySgATR93yvJlYeqNNZMZgglwPNSIW4gZZpmbl7sCs959+t3ZyVE= siva@MLBPBCL-106780' >> /home/ubuntu/.ssh/authorized_keys
EOF
}
