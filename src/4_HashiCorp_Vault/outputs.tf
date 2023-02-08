
output "vault_db_username_secret" {
    #value = data.vault_generic_secret.vault_db_username.data_json
    value = data.vault_generic_secret.vault_db_username.data["db_username"]
    sensitive = true
}

output "vault_db_password_secret" {
    #value = data.vault_generic_secret.vault_db_password.data_json    
    value = data.vault_generic_secret.vault_db_password.data["db_password"]
    sensitive = true
}
