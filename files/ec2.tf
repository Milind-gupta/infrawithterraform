
resource "aws_key_pair" "loginkey" {
  key_name   = "login-key"
  public_key = file("${path.module}/id_rsa.pub")
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
   
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/id_rsa")
      host        = aws_instance.myec2a.public_ip
    }
    
    inline = [
      "echo 'build ssh' ",
      "sudo yum update -y"
      #"sudo amazon-linux-extras install nginx1 -y",
      #"sudo systemctl start nginx",
      #"sudo amazon-linux-extras install ansible2 -y"
    ]
  }
    
   provisioner "local-exec" {
    command = "echo ${aws_instance.myec2a.public_ip} > inventory"
  }

  provisioner "local-exec" {
  #  command = "ansible-playbook task.yaml"
    command = "ansible all -m shell -a 'yum -y install httpd; systemctl restart httpd'"
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

output "ip" {
  value = aws_instance.myec2a.public_ip
}



