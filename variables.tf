variable "hcloud_token" {
    default = ""
}
variable "k8s_master_node_type" {
  type = string
  default = "cx11"
  description = "Kubernetes Master Node type"

  
}

variable "k8s_agent_node_type" {
  type = string
  default = "cx11"
  description = "Kubernetes Agent Node type"

  
}

variable "pritunl_node_type" {
  type = string
  default = "cx11"
  description = "pritunl Node type"

  
}


variable "number_master_node" {
  default = "3"
  description = "Number of Kubernetes Master Nodes"

  
}

variable "number_agent_node" {
  default = "3"
  description = "Number of Kubernetes Agent Nodes"

  
}
variable "networks" {
  type        = map(any)
  default = {
    private_a = "10.27.0.0/22"
    private_b = "10.27.4.0/22"
    private_c = "10.27.8.0/22"
    vpn_destintion  = "10.27.32.0/24"
    vpc_cidr =  "10.27.0.0/16"
  }

}

variable "hcloud_location" {
  type = string
  default = "nbg1"
  
}

variable "zone" {
  type = string
  default = "eu-central"

}
variable "infra_name" {
  type        = string
  description = "infrastructure name, should be domain compatible"
}

variable "vault_token" {
  type = string
  
}