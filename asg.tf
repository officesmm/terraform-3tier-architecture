data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_launch_template" "app" {
  image_id      = data.aws_ami.al2023.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.app.id]

  user_data = base64encode(<<EOF
#!/bin/bash
set -eux

dnf -y update
dnf -y install git nodejs npm unzip

# PM2
npm install -g pm2

# App directory
mkdir -p /var/www/app
chown ec2-user:ec2-user /var/www/app

#!/bin/bash
#dnf -y install nginx
#sed -i "s/80/${var.app_port}/g" /etc/nginx/nginx.conf
#systemctl enable nginx && systemctl start nginx
EOF
)
}

resource "aws_autoscaling_group" "app" {
  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  vpc_zone_identifier = values(aws_subnet.private_app)[*].id
  target_group_arns  = [aws_lb_target_group.app.arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}
