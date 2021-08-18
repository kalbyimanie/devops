module "ssh-keys" {
  source = "../../../../modules/ssh-keys"
  ssh_pub_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAm2D85KdBOcDGMcxkGB7g1fQuQO4koTHXnQhKeh61ms8qugXV0vxsJ/dHSMgjYdFHbK85F0soVvc7btO7mevr/GFfAde3c5+Zbm03goZYYN4MqPPrO9KTtyaS704MFdNGgkq9G/IX6U04llNBVeNUPAirfJaJ7WtweVOaaDijL0dXnaunD6Zja9O38l5dkuRZ1KBgB0AzMk7mkk5baifkyU45RTTTbCiZXgwJJNgiVHBeuIYK1ZAJV49sGKXyfyhQLmhloLH5Xi9v5i+h3c0mQuHEBiy656BzuoL7wXo8Lf9Ee0FG7KXZ++HrK4tDh8Qa33b/d7ZWb9VuCi2LYhLJNPHXccSD7zMbBT2fj6603ndTahm2asEJ/yWQnv5lyNQyBdXoOh0HcrmHLYLJ41SU/gwRz2rQawMSGo7nV5Fq31A1/7z9DAZIe1I/tNXBeQ2LM/meIObSq9cUBa0uQXclJNRU5Hmq9rcGWqAFVLOT67SqAlYonmwq4eo7XAoRlvE= kalbyimanie@Kalby-Imanie.local"
  ]
  project_id = "road-to-expert"
  key_name   = "kalby"
}
