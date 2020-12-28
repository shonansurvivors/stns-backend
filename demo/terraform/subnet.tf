resource "aws_subnet" "public" {
  count = 2

  availability_zone       = var.availability_zones[count.index]
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index)
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    Name = "${var.system_name}-${var.env_name}-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = 2

  availability_zone       = var.availability_zones[count.index]
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index + length(aws_subnet.public))
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    Name = "${var.system_name}-${var.env_name}-private-subnet-${count.index}"
  }
}
