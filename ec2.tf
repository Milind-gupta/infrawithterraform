resource "aws_key_pair" "loginkey" {
  key_name   = "login-key"
  public_key = file("/id_rsa.pub")
}

resource "aws_instance" "myec2a" {
  ami                    = "ami-04db49c0fb2215364"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.loginkey.key_name
  subnet_id              = aws_subnet.public-1.id
  vpc_security_group_ids = [aws_security_group.pub-sg.id]
  tags = {
    Name = "Bastion host"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'build ssh' ",
      # "sudo amazon-linux-extras install nginx1 -y",
      # "sudo systemctl start nginx",
      "sudo amazon-linux-extras install ansible2 -y"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/id_rsa")
      host        = aws_instance.myec2a.public_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i  ${aws_instance.myec2a.public_ip} --private-key /id_rsa task.yml"
  }
}

resource "aws_instance" "myec2b" {
  ami           = "ami-04db49c0fb2215364"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.loginkey.key_name

  subnet_id              = aws_subnet.private-2.id
  vpc_security_group_ids = [aws_security_group.pri-sg.id]
  tags = {
    Name = "web"
  }
}

resource "aws_instance" "myec2c" {
  ami           = "ami-04db49c0fb2215364"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.loginkey.key_name

  subnet_id              = aws_subnet.private-1.id
  vpc_security_group_ids = [aws_security_group.pri-sg.id]
  tags = {
    Name = "web"
  }

}
