# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

variable "environment" {
  type        = string
  description = "Selected environment for cluster deploy"
  default     = "dev"
}

variable "region" {
  type        = string
  description = "DO region to deploy the Kubernetes cluster"
  default     = "sfo3"
}

variable "node_type" {
  type        = string
  description = "DO machine type to deploy worker nodes"
  default     = "s-4vcpu-8gb"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace to deploy EFK stack"
  default     = "logging"
}
