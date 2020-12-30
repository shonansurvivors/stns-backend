resource "aws_instance" "bastion" {
  ami           = "ami-01748a72bed07727c" // Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-01748a72bed07727c (64-bit x86)
  instance_type = "t3.micro"
  key_name      = "${var.system_name}-${var.env_name}"
  security_groups = [
    aws_security_group.ssh.id
  ]
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "${var.system_name}-${var.env_name}-bastion"
  }
}
