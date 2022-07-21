####################################################################

# Creating ALB:

####################################################################

resource "aws_lb" "sample_lb" {
  name               = "alb-test"
  internal           = false
  load_balancer_type = "application" 
  security_groups    = var.security_grp
  subnets            = var.subnets
  tags = {
    Name = "sc365-alb-external"
  }
}

####################################################################

# Creating Target group:

####################################################################

resource "aws_lb_target_group" "sample_tg" {
   name               = "albtg"
   target_type        = "instance"
   port               = 80
   protocol           = "HTTP"
   vpc_id             = "vpc-0a492f221d3412d80"
   health_check {
      healthy_threshold   = var.health_check["healthy_threshold"]
      interval            = var.health_check["interval"]
      unhealthy_threshold = var.health_check["unhealthy_threshold"]
      timeout             = var.health_check["timeout"]
      path                = var.health_check["path"]
      port                = var.health_check["port"]
  }
}

####################################################################

# Attach the target group for ALB:

####################################################################

resource "aws_lb_target_group_attachment" "tg_attachment_test" {
    target_group_arn = aws_lb_target_group.sample_tg.arn
    target_id        = aws_instance.nginx.id
    port             = 80
}

####################################################################

# Creating EC2 Instance to test ALB:

####################################################################

resource "aws_instance" "nginx" {
  ami           = "ami-00f005e395638ae78"
  instance_type = "t3a.nano"
  vpc_security_group_ids = var.security_grp
  subnet_id       = "subnet-0f8543b50e95a2a55"

  tags = {
    Name = "sc365-alb-external-testing"
  }
}

####################################################################

# Creating Listener rules for HTTP/HTTPS traffic:

####################################################################

resource "aws_lb_listener" "lb_listener_http" {
   load_balancer_arn    = aws_lb.sample_lb.id
   port                 = "80"
   protocol             = "HTTP"
   default_action {
    target_group_arn = aws_lb_target_group.sample_tg.id
    type             = "forward"
  }
}

resource "aws_lb_listener" "lb_listner_https" {
  load_balancer_arn = aws_lb.sample_lb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-west-2:780616323728:certificate/9bb2688e-e351-47d2-b515-663383e0bc2d"
  default_action {
     type             = "forward"
     target_group_arn = aws_lb_target_group.sample_tg.id
  }
}

####################################################################

# Creating DNS record to check ALB:

####################################################################

resource "aws_route53_record" "my_domain_test" {
  zone_id         = "Z0628016K380J9ZRCU92"
  name            = "alb-test"
  type            = "CNAME"
  ttl             = 60
  records         = ["${aws_lb.sample_lb.dns_name}"]
  allow_overwrite = true
}