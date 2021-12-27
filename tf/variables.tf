# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

variable "environment" {
  type        = string
  description = "Selected environment for cluster deploy"
  default     = "dev"
}

variable "logging_namespace" {
  type    = string
  default = "logging"
}
