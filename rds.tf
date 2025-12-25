resource "aws_db_subnet_group" "db" {
  subnet_ids = values(aws_subnet.private_db)[*].id
}

resource "aws_db_instance" "this" {
  engine               = "mysql"
  instance_class       = "db.t4g.micro"
  allocated_storage    = 20
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible  = false
  skip_final_snapshot  = true
}
