data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "web_server" {
  count                       = length(module.vpc.public_subnets)
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = element(module.vpc.public_subnets, count.index)

  vpc_security_group_ids = [
    aws_security_group.http-sg.id,
  ]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd.service
    systemctl enable httpd.service
    EC2_AVAIL_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
    echo "<h1>Hello World From at at $(hostname -f) in AZ <b>$EC2_AVAIL_ZONE</b> </h1>" > /var/www/html/index.html
        EOF

  tags = {
    Name = "Instance_${count.index + 1}"
  }
}
