variable "ec2_tag" {
  default = "student-instance"
}

variable "ssh_key" {
  description = "SSH key name"
  default     = "workshop-key2"
}

variable "git_branch" {}
variable "git_repo" {}
