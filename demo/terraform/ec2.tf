resource "aws_instance" "bastion" {
  ami           = "ami-01748a72bed07727c" // Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-01748a72bed07727c (64-bit x86)
  instance_type = "t3.micro"
  key_name      = "${var.system_name}-${var.env_name}"
  subnet_id     = aws_subnet.public[0].id
  user_data     = file("./user_data/bastion.sh")
  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.vpc.id,
  ]

  tags = {
    Name = "${var.system_name}-${var.env_name}-bastion"
  }
}

resource "aws_instance" "backend" {
  count = 1

  ami           = "ami-01748a72bed07727c" // Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-01748a72bed07727c (64-bit x86)
  instance_type = "t3.micro"
  key_name      = "${var.system_name}-${var.env_name}"
  subnet_id     = aws_subnet.private[0].id
  vpc_security_group_ids = [
    aws_security_group.vpc.id,
  ]

  tags = {
    Name = "${var.system_name}-${var.env_name}-backend-${count.index}"
  }
}
