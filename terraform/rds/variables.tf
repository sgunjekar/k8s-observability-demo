variable "region" {
  default = "ap-south-1"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  description = "Security group to attach to MongoDB cluster"
  type        = string
}
