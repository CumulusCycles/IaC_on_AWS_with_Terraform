resource "aws_security_group" "ccWebserverSecurityGroup" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  vpc_id      = var.cc_vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ccWebserverSecurityGroup"
    Project = "CC TF Demo"
  }
}

resource "aws_lb" "ccLoadBalancer" {
  load_balancer_type = "application"
  subnets            = [var.cc_public_subnets[0].id, var.cc_public_subnets[1].id]
  security_groups    = [aws_security_group.ccWebserverSecurityGroup.id]
  tags = {
    Name    = "ccLoadBalancer"
    Project = "CC TF Demo"
  }
}

resource "aws_lb_listener" "ccLbListener" {
  load_balancer_arn = aws_lb.ccLoadBalancer.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.ccTargetGroup.id
    type             = "forward"
  }
}

resource "aws_lb_target_group" "ccTargetGroup" {
  name     = "example-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.cc_vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name    = "ccTargetGroup"
    Project = "CC TF Demo"
  }
}

resource "aws_lb_target_group_attachment" "webserver1" {
  target_group_arn = aws_lb_target_group.ccTargetGroup.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "webserver2" {
  target_group_arn = aws_lb_target_group.ccTargetGroup.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}

resource "aws_instance" "webserver1" {
  ami                         = local.ami_id
  instance_type               = local.instance_type
  key_name                    = local.key_name
  subnet_id                   = var.cc_public_subnets[0].id
  security_groups             = [aws_security_group.ccWebserverSecurityGroup.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash -xe
              sudo su 
              yum update -y 
              yum install -y httpd 
              echo "<h1>Hello, World!</h1>server: ccWebServer1" > /var/www/html/index.html 
              echo "healthy" > /var/www/html/hc.html 
              service httpd start
              EOF
}

resource "aws_instance" "webserver2" {
  ami                         = local.ami_id
  instance_type               = local.instance_type
  key_name                    = local.key_name
  subnet_id                   = var.cc_public_subnets[0].id
  security_groups             = [aws_security_group.ccWebserverSecurityGroup.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash -xe
              sudo su 
              yum update -y 
              yum install -y httpd 
              echo "<h1>Hello, World!</h1>server: ccWebServer2" > /var/www/html/index.html 
              echo "healthy" > /var/www/html/hc.html 
              service httpd start
              EOF    
}