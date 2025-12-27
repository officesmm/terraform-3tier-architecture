data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

locals {
  s3_bucket_name = replace(var.s3_bucket_arn, "arn:aws:s3:::", "")
}

resource "aws_launch_template" "app" {
  image_id               = data.aws_ami.al2023.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.app.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm.name
  }

  user_data = base64encode(<<EOF
#!/bin/bash
set -eux

# ---------- System ----------
dnf -y update
dnf -y install nodejs npm unzip awscli

# ---------- PM2 ----------
npm install -g pm2

# ---------- App directory ----------
APP_DIR="/var/www/app"
mkdir -p $APP_DIR
chown ec2-user:ec2-user $APP_DIR

# ---------- Deploy app ----------
cd $APP_DIR
aws s3 cp s3://${local.s3_bucket_name}/app.zip app.zip
unzip -o app.zip
npm install --production

# ---------- Start app ----------
pm2 start app.js --name app
pm2 save
EOF
  )
}

resource "aws_autoscaling_group" "app" {
  min_size         = 1
  max_size         = 8
  desired_capacity = 2

  vpc_zone_identifier = values(aws_subnet.private_app)[*].id
  target_group_arns   = [aws_lb_target_group.app.arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}
