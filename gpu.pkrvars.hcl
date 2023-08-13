region        = "eu-central-1"
instance_type = "g4dn.8xlarge"

ami_block_device_mappings = [
  {
    device_name           = "/dev/xvda"
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  },
]

launch_block_device_mappings = [
  {
    device_name           = "/dev/xvda"
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  },
]

shell_provisioner1 = {
  scripts = [
    "scripts/install.sh",
    "scripts/cleanup.sh",
  ]
}
