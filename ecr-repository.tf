resource "aws_ecr_repository" "jpv_ecr_repository" {
  name                 = "jpv_ecr_repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}