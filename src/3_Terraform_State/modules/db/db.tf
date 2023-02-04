resource "aws_db_subnet_group" "ccDBSubnetGroup" {
  name = "cc-db-subnet-group"
  subnet_ids = [
    var.cc_private_subnets[0].id,
    var.cc_private_subnets[1].id
  ]
  tags = {
    Name    = "ccDBSubnetGroup"
    Project = "CC TF Demo"
  }
}

resource "aws_security_group" "ccDBSecurityGroup" {
  name   = "cc-db-security-group"
  vpc_id = var.cc_vpc_id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = [
      var.cc_private_subnet_cidrs[0],
      var.cc_private_subnet_cidrs[1]
    ]
  }
  tags = {
    Name    = "ccDBSecurityGroup"
    Project = "CC TF Demo"
  }
}

resource "aws_db_instance" "ccRDS" {
  availability_zone      = var.db_az
  db_subnet_group_name   = aws_db_subnet_group.ccDBSubnetGroup.name
  vpc_security_group_ids = [aws_security_group.ccDBSecurityGroup.id]
  allocated_storage      = 20
  storage_type           = "standard"
  engine                 = "postgres"
  engine_version         = "12"
  instance_class         = "db.t2.micro"
  name                   = var.db_name
  username               = var.db_user_name
  password               = var.db_user_password
  skip_final_snapshot    = true
  tags = {
    Name    = "ccRDS"
    Project = "CC TF Demo"
  }
}