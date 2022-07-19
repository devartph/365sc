resource "aws_vpc" "sc365sc-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  instance_tenancy = "default"
  tags = {
    Name = "sc365"
  }
}

resource "aws_subnet" "sc365sc-subnet-public-1" {
  vpc_id = "${aws_vpc.sc365sc-vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-west-2a"
  tags = {
    Name = "sc365-subnet-public-1"
  }
}

resource "aws_subnet" "sc365sc-subnet-private-1" {
  vpc_id = "${aws_vpc.sc365sc-vpc.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "sc365-subnet-private-1"
  }
}

resource "aws_internet_gateway" "sc365sc-igw" {
  vpc_id = "${aws_vpc.sc365sc-vpc.id}"
  tags = {
    Name = "sc365"
  }
}

resource "aws_route_table" "sc365sc-public-crt" {
  vpc_id = "${aws_vpc.sc365sc-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = "${aws_internet_gateway.sc365sc-igw.id}" 
  }
  tags = {
    Name = "sc365sc-public-crt"
  }
}

resource "aws_route_table" "sc365sc-private-crt" {
  vpc_id = "${aws_vpc.sc365sc-vpc.id}"
  tags = {
    Name = "sc365sc-private-crt"
  }
}

resource "aws_route_table_association" "sc365sc-crta-public-subnet-1" {
  subnet_id = "${aws_subnet.sc365sc-subnet-public-1.id}"
  route_table_id = "${aws_route_table.sc365sc-public-crt.id}"
}

resource "aws_route_table_association" "sc365sc-crta-private-subnet-1" {
  subnet_id = "${aws_subnet.sc365sc-subnet-private-1.id}"
  route_table_id = "${aws_route_table.sc365sc-private-crt.id}"
}

resource "aws_security_group" "sc365sc-http-allowed" {
  vpc_id = "${aws_vpc.sc365sc-vpc.id}"
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sc365sc-http-allowed"
  }
}