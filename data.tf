
data "template_file" "pritunl_startup_script" {
  template = file("${path.module}/files/pritunl.sh")
  vars = {
    pritunl_link_uri =  "http://test"#data.vault_generic_secret.pritunl_link_uri.data[var.infra_name]
  }
}

# data "vault_generic_secret" "pritunl_link_uri" {
#   path = "infra-secrets/pritunl"
# }
