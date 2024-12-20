data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

#tfsec:ignore:aws-ec2-enforce-http-token-imds:2025-01-01
resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
#  instance_type = each.value["instance_type"]g
  availability_zone = "us-east-1a"


  root_block_device {
      encrypted = true
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_devices
    iterator = device
    content {
      device_name = device.value["device_name"]
      encrypted   = device.value["encrypted"]
      volume_size = device.value["volume_size"]
    }
  }

  tags = {
    Name = var.nome
    Env  = var.environment
    Plataforma = data.aws_ami.ubuntu.platform_details
  }
}

