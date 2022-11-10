resource "aws_db_instance" "db-jumia-phone-validator" {
  allocated_storage    = 10
  db_name              = "jumia_phone_validator"
  engine               = "postgres"
  engine_version       = "13.7"
  instance_class       = "db.t3.micro"
  username             = "jumia"
  password             = "1234qwer."
  db_subnet_group_name = aws_db_subnet_group.subnet_group_phonevalidator.name
  skip_final_snapshot  = true
}