ui = true
disable_mlock = true
disable_sealwrap = true
disable_clustering =  true
enable_response_header_hostname = true
log_level                       = "verbose"





storage "file" {
  path = "/vault/file"
}
listener "tcp" {
  address       = "0.0.0.0:8200"
  path          = "/vault"
  tls_disable   = 1
}