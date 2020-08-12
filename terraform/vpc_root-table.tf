resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.favorite_videos_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.favorite_videos_GW.id
  }

  tags = {
    Name = "favorite_videos_RT"
  }
}

resource "aws_route_table_association" "puclic-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "puclic-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.public-route.id
}
