resource "aws_ecr_repository" "main" {
  name = "crs"
  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "crs"
  }
}

output "repository_url" {
  value = aws_ecr_repository.main.repository_url
}