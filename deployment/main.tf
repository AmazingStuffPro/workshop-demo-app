
provider "aws" {
  region = "eu-west-1"
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpcs" "vpcs" {
  tags {
    Name = "workshop-vpc"
  }
}

data "aws_subnet_ids" "subnets" {
  vpc_id = "${data.aws_vpcs.vpcs.ids[0]}"
}

data "template_file" "deploy_app" {
  template = "${file("${path.module}/deploy.sh.tpl")}"

  vars {
    git_branch = "${var.git_branch}"
    git_repo   = "${var.git_repo}"
  }
}

resource "aws_instance" "app_ec2" {
  ami           = "${data.aws_ami.ami.id}"
  instance_type = "t2.micro"
  subnet_id     = "${data.aws_subnet_ids.subnets.ids[0]}"
  key_name      = "${var.ssh_key}"

  tags {
    Name = "${var.ec2_tag}"
  }

  provisioner "file" {
    content     = "${data.template_file.deploy_app.rendered}"
    destination = "/tmp/deploy.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("~/.ssh/${var.ssh_key}.pem")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/deploy.sh",
      "sudo /tmp/deploy.sh",
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("~/.ssh/${var.ssh_key}.pem")}"
    }
  }
}
