variable "repo_url" {
  description = "Repository URL where application definitions are stored"
  default     = "https://github.com/vgurukool/tla-idp"
  type        = string
}

variable "tags" {
    description = "Tags to apply to AWS resources"
    default = {
        env = "dev"
        project = "cnoe"
    }
    type = map(string)
}

variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "EKS Cluster name"
  default     = "cnoe-ref-impl"
  type        = string
}

variable "hosted_zone_id" {
  description = "If using external DNS, specify the Route53 hosted zone ID. Required if enable_dns_management is set to true."
  default     = "Z01603771C794UPQN6AOI"
  type        = string
}

variable "domain_name" {
  description = "if external DNS is not used, this value must be provided."
  default     = "svc.cluster.local"
  type        = string
}

variable "organization_url" {
  description = "github organization url"
  default     = "https://github.com/vgurukool"
  type        = string
}

variable "enable_dns_management" {
  description = "Do you want to use external dns to manage dns records in Route53?"
  default     = true
  type        = bool
}

variable "enable_external_secret" {
  description = "Do you want to use external secret to manage dns records in Route53?"
  default     = true
  type        = bool
}
