locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")

  target_ami_name = "${var.ami_name_prefix}-${var.eks_version}-${local.timestamp}"
}

data "amazon-parameterstore" "this" {
  name   = "/aws/service/eks/optimized-ami/${var.eks_version}/${var.base_image_name}/recommended/image_id"
  region = var.aws_region
}

source "amazon-ebs" "this" {
  ami_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvda"
    volume_size           = var.volume_size
    volume_type           = "gp3"
  }

  ami_description         = var.ami_description
  ami_name                = local.target_ami_name
  ami_virtualization_type = "hvm"
  instance_type           = var.instance_type

  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvda"
    volume_size           = var.volume_size
    volume_type           = "gp3"
  }

  region = var.aws_region

  run_tags = {
    Name = local.target_ami_name
  }

  source_ami = data.amazon-parameterstore.this.value
  subnet_id  = var.subnet_id

  communicator                = "ssh"
  ssh_interface               = "public_dns"
  ssh_username                = var.ssh_username
  associate_public_ip_address = true

  tags = {
    source_image_name = "{{ .SourceAMIName }}"
    ami_type          = "amazon-eks-gpu"
  }
}

build {
  sources = ["source.amazon-ebs.this"]

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"

    scripts = [
      "scripts/install.sh",
      "scripts/cleanup.sh",
    ]
  }
}
