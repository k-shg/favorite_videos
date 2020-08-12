resource "aws_instance" "favorite_videos" {
  ami                     = var.ami
  instance_type           = var.instance_type
  vpc_security_group_ids = [aws_security_group.favorite_videos.id]
  subnet_id              = aws_subnet.public-a.id
  key_name               = aws_key_pair.favorite_videos.id

  tags = {
    Name = "ec2_favorite_videos"
  }
}

resource "aws_eip" "favorite_videos" {
  instance = aws_instance.favorite_videos.id
  vpc      = true
}

resource "aws_key_pair" "favorite_videos" {
  key_name   = "terraform"
  public_key = file("~/.ssh/terraform.pub")
}
