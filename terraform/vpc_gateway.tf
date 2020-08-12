resource "aws_internet_gateway" "favorite_videos_GW" {
  vpc_id = aws_vpc.favorite_videos_vpc.id

  tags = {
    Name = "favorite_videos_GW"
  }
}
