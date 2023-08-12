variable "aws_region" {
  description = "Region where AMI will be created"
  type        = string
  default     = "eu-central-1"
}

variable "base_image_name" {
  description = "The base image name to use when creating the AMI. For arm64, use `amazon-linux-2-arm64`"
  type        = string
  default     =  "amazon-linux-2"
}

variable "volume_size" {
  description = "Size of the AMI root EBS volume"
  type        = number
  default     = 20
}

variable "eks_version" {
  description = "The EKS cluster version associated with the AMI created"
  type        = string
  default     = "1.27"
}

variable "source_ami_arch" {
  description = "The architecture of the source AMI. Either `x86_64` or `arm64`"
  type        = string
  default     = "x86_64"
}

variable "source_ami_owner" {
  description = "The owner of the source AMI"
  type        = string
  default     = "amazon"
}

variable "ssh_username" {
  description = "The SSH user used when connecting to the AMI for provisioning"
  type        = string
  default     = "ec2-user"
}

variable "subnet_id" {
  description = "The subnet ID where the AMI can be created. Required if a default VPC is not present in the `aws_region`"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The instance type to use when creating the AMI. Note: this should be adjusted based on the `source_ami_arch` provided"
  type        = string
  default     = "g4dn.8xlarge"
}

variable "ami_name_prefix" {
  description = "The prefix to use when creating the AMI name. i.e. - `<ami_name_prefix>-<eks_version>-<timestamp>"
  type        = string
  default     = "amazon-eks-gpu"
}

variable "ami_description" {
  description = "The description to use when creating the AMI"
  type        = string
  default     = "Amazon EKS AL2 GPU image"
}
