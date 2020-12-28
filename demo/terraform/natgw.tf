resource "aws_nat_gateway" "ngw" {
  count      = var.ngw_count
  depends_on = [aws_internet_gateway.igw]

  allocation_id = aws_eip.ngw[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.system_name}-${var.env_name}-ngw-${count.index}"
  }
}

resource "aws_eip" "ngw" {
  count      = var.ngw_count
  depends_on = [aws_internet_gateway.igw]

  vpc = true

  tags = {
    Name = "${var.system_name}-${var.env_name}-eip-ngw-${count.index}"
  }
}
