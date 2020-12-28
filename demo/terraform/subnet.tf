/*
public subnet and more
*/
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

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.system_name}-${var.env_name}-public-route-table"
  }
}

resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.public.id
}

resource "aws_route_table_association" "public" {
  count = 2

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}

/*
private subnet and more
 */
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

resource "aws_route_table" "private" {
  count = 2

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.system_name}-${var.env_name}-private-route-table-${count.index}"
  }
}

resource "aws_route" "private" {
  count = 2

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[0].id
  route_table_id         = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "private" {
  count = 2

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}
