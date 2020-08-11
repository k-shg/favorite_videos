# ====================
#
# VPC
#
# ====================
resource "aws_vpc" "favorite_videos_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true # DNS解決を有効化
  enable_dns_hostnames = true # DNSホスト名を有効化

  tags = {
    Name = "favorite_videos_vpc"
  }
}

# ====================
#
# Subnet
#
# ====================
resource "aws_subnet" "public-a" {
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  vpc_id            = aws_vpc.favorite_videos_vpc.id

  # trueにするとインスタンスにパブリックIPアドレスを自動的に割り当ててくれる
  map_public_ip_on_launch = true

  tags = {
    Name = "favorite_videos_1a"
  }
}

# ====================
#
# Internet Gateway
#
# ====================
resource "aws_internet_gateway" "favorite_videos_GW" {
  vpc_id = aws_vpc.favorite_videos_vpc.id

  tags = {
    Name = "favorite_videos_GW"
  }
}

# ====================
#
# Route Table
#
# ====================
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
