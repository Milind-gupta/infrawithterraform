#####################################Elastic Ip#############################################################
resource "aws_eip" "elasticip" {}


###################################Nat gateway###############################################################

resource "aws_nat_gateway" "ng" {
  connectivity_type = "public"
  allocation_id     = aws_eip.elasticip.id
  subnet_id         = aws_subnet.public-1.id

  tags = {
    Name = "Natgateway-1"
  }

}
#################################################Internet Gateway##############################################

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}


##############################################Route Table####################################################

resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "public-rt"
  }
}


resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ng.id
  }

  tags = {
    Name = "private-rt"
  }
}

########################################Route table association#############################################

resource "aws_route_table_association" "private-rt-association-private-1" {
  #type = list
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.privateroute.id
}


resource "aws_route_table_association" "private-rt-association-private-2" {
  #type = list
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.privateroute.id
}


resource "aws_route_table_association" "private-rt-association-private-3" {
  #type = list
  subnet_id      = aws_subnet.private-3.id
  route_table_id = aws_route_table.privateroute.id
}


resource "aws_route_table_association" "private-rt-association-private-4" {
  #type = list
  subnet_id      = aws_subnet.private-4.id
  route_table_id = aws_route_table.privateroute.id
}

resource "aws_route_table_association" "public-rt-association" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.publicroute.id
}

