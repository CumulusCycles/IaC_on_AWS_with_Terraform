data "vault_generic_secret" "vault_db_username" {
    path = "secret/db-username-secret"
}

data "vault_generic_secret" "vault_db_password" {
    path = "secret/db-password-secret"
}