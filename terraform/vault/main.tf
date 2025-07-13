provider "vault" {
  address = "http://127.0.0.1:8200"
  # No need to hardcode or reference token
}

resource "vault_policy" "payment_policy" {
  name = "payment-service"

  policy = <<EOT
path "secret/data/payment-service/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_kv_secret_v2" "payment_secrets" {
  mount = "secret"
  name  = "payment-service/config"

  data_json = jsonencode({
    DB_USERNAME = "secure_user"
    DB_PASSWORD = "secure_pass"
  })
}
