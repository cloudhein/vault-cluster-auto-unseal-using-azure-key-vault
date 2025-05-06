ui = true
disable_mlock = true

# Logging
log_level = "debug"
log_file = "/vault/logs/vault.log"
log_format = "json"

# Post Unseal Trace - for further exploration
enable_post_unseal_trace = true
post_unseal_trace_directory = "/vault/logs/post-unseal-trace"

# High Availability
storage "raft" {
  path = "/vault/file"
  node_id = "node2"

  #added
  retry_join {
    leader_api_addr = "http://vault-server1:8200"
  }

  retry_join {
    leader_api_addr = "http://vault-server3:8200"
  }
}

# Server config
api_addr = "http://vault-server2:8200"
cluster_addr = "https://vault-server2:8201"
cluster_name = "vault-az-cluster"

# Seal Type 
seal "azurekeyvault" {
    #tenant_id  = "paste_quoted_tenant_id_from_azure"
    #client_id  = "paste_quoted_entra_client_id_from_azure"
    #client_secret = "paste_quoted_entra_app_secret_from_azure"
    vault_name = "vault-key-auto-unseal"
    key_name  = "unseal-key"
}

# Request Listeners
listener "tcp" {
    address = "0.0.0.0:8200"
    tls_disable = true
}

