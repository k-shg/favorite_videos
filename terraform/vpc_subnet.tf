resource "aws_subnet" "public-a" {
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"
  vpc_id            = aws_vpc.favorite_videos_vpc.id
  map_public_ip_on_launch = true #サブネットで起動したインスタンスにパブリックIPを許可する

  tags = {
    Name = "favorite_videos_1a"
  }
}


resource "aws_subnet" "public-c" {
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1c"
  vpc_id            = aws_vpc.favorite_videos_vpc.id
  map_public_ip_on_launch = true #サブネットで起動したインスタンスにパブリックIPを許可する

  tags = {
    Name = "favorite_videos_1c"
  }
}
