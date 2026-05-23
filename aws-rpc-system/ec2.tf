#API VM

resource "aws_instance" "api" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  private_ip = "10.0.1.10"

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.rpc_sg.id
  ]

  user_data = file("${path.module}/cloud-init/api.sh")

  tags = {
    Name = "api-vm"
  }
}

# Engine VM

resource "aws_instance" "engine" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id  = aws_subnet.private.id
  private_ip = "10.0.2.10"

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.rpc_sg.id
  ]

  user_data = file("${path.module}/cloud-init/engine.sh")

  tags = {
    Name = "engine-vm"
  }
}

#Pyhton Worker

resource "aws_instance" "python" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id  = aws_subnet.private.id
  private_ip = "10.0.2.11"

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.rpc_sg.id
  ]

  user_data = file("${path.module}/cloud-init/python-worker.sh")

  tags = {
    Name = "python-worker"
  }
}

#TypeScript worker

resource "aws_instance" "ts" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id  = aws_subnet.private.id
  private_ip = "10.0.2.12"

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.rpc_sg.id
  ]

  user_data = file("${path.module}/cloud-init/ts-worker.sh")

  tags = {
    Name = "ts-worker"
  }
}

#Elastic IP

resource "aws_eip" "api_eip" {

  instance = aws_instance.api.id

  domain = "vpc"
}