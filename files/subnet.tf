resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnetCidr[0]
  availability_zone       = var.az[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "publicsubnet-1"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnetCidr[1]
  availability_zone = var.az[0]
  tags = {
    Name = "privatesubnet-1"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnetCidr[2]
  availability_zone = var.az[1]
  tags = {
    Name = "privatesubnet-2"
  }
}

resource "aws_subnet" "private-3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnetCidr[3]
  availability_zone = var.az[0]
  tags = {
    Name = "privatesubnet-3"
  }
}

resource "aws_subnet" "private-4" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnetCidr[4]
  availability_zone = var.az[1]
  tags = {
    Name = "privatesubnet-4"
  }
}

