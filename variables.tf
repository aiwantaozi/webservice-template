variable "image" {
  type        = string
  description = "Docker image name"
}
variable "ports" {
  type        = list(number)
  description = "Service ports to expose"
  default     = [80]
}
variable "env" {
  type        = map(string)
  description = "Name and value pairs to set as the environment variables"
  default     = {}
}
variable "replicas" {
  type        = number
  description = "Replicas to deploy"
  default     = 1
}
variable "request_cpu" {
  type        = string
  description = "CPU request. e.g. 0.5, 1, 2"
  default     = "0.1"
}
variable "request_memory" {
  type        = string
  description = "Memory request. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi"
  default     = "128Mi"
}
variable "limit_cpu" {
  type        = string
  description = "CPU limit. e.g. 0.5, 1, 2"
  default     = ""
}
variable "limit_memory" {
  type        = string
  description = "Memory limit. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi"
  default     = ""
}


