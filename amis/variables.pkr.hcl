variable "owner" {
  type        = string
  description = "Owner tag to which the artifacts belong"
  default     = "sai"
}

variable "aws_region" {
  type        = string
  description = "AWS Region for image"
  default     = "ap-southeast-1"
}
variable "aws_instance_type" {
  type        = string
  description = "Instance Type for Image"
  default     = "t2.small"
}

variable "vault_version" {
  description = "Version of Vault CLI to install"
  type        = string
  default     = "1.20.4+ent"
}

variable "ami_owner_id" {
  description = "AWS Account ID that owns the base AMI (099720109477 = Canonical for Ubuntu)"
  type        = string
  default     = "099720109477"
}