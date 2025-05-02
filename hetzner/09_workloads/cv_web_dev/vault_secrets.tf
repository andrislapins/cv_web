
resource "random_password" "postgres_password" {
  length  = 16
  lower   = true
  upper   = true
  number  = true
  special = false
}

resource "vault_kv_secret_v2" "postgres_password" {
  mount = "kv"
  name  = "cv_web_dev/postgres_password"

  data_json = jsonencode({
    password = random_password.postgres_password.result
  })
}

resource "random_password" "app_user_password" {
  length  = 16
  lower   = true
  upper   = true
  number  = true
  special = false
}

resource "vault_kv_secret_v2" "app_user_password" {
  mount = "kv"
  name  = "cv_web_dev/app_user_password"

  data_json = jsonencode({
    password = random_password.app_user_password.result
  })
}

resource "random_password" "app_user_flyway_password" {
  length  = 16
  lower   = true
  upper   = true
  number  = true
  special = false
}

resource "vault_kv_secret_v2" "app_user_flyway_password" {
  mount = "kv"
  name  = "cv_web_dev/app_user_flyway_password"

  data_json = jsonencode({
    password = random_password.app_user_flyway_password.result
  })
}

resource "random_password" "app_user_temporal_password" {
  length  = 16
  lower   = true
  upper   = true
  number  = true
  special = false
}

resource "vault_kv_secret_v2" "app_user_temporal_password" {
  mount = "kv"
  name  = "cv_web_dev/app_user_temporal_password"

  data_json = jsonencode({
    password = random_password.app_user_temporal_password.result
  })
}