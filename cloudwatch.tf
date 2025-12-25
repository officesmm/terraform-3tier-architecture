############################
# CloudWatch Alarms
############################

# ---- ASG: High CPU ----
resource "aws_cloudwatch_metric_alarm" "asg_high_cpu" {
  alarm_name          = "${var.name}-asg-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app.name
  }

  alarm_description = "ASG average CPU > 70%"
}

# ---- ALB: Unhealthy targets ----
resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_targets" {
  alarm_name          = "${var.name}-alb-unhealthy-targets"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 0

  dimensions = {
    TargetGroup  = aws_lb_target_group.app.arn_suffix
    LoadBalancer = aws_lb.this.arn_suffix
  }

  alarm_description = "ALB has unhealthy targets"
}

# ---- RDS: High CPU ----
resource "aws_cloudwatch_metric_alarm" "rds_high_cpu" {
  alarm_name          = "${var.name}-rds-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 75

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.id
  }

  alarm_description = "RDS CPU > 75%"
}

# ---- RDS: Low Free Storage ----
resource "aws_cloudwatch_metric_alarm" "rds_low_storage" {
  alarm_name          = "${var.name}-rds-low-storage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"

  # 2 GB
  threshold = 2 * 1024 * 1024 * 1024

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.id
  }

  alarm_description = "RDS free storage < 2GB"
}
