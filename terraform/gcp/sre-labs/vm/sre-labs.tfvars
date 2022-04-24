number_of_instances = 1
project_id          = "sre-labs-220713"
instance_name       = "kalby-playground"
machine_type        = "custom-4-${4 * 1024}"
image_name          = "ubuntu-1804-bionic-v20210817"
extended_disk_size  = 10
extended_disk_type  = "pd-ssd"
boot_disk_size      = 10
boot_disk_type      = "pd-ssd"
zone                = "asia-southeast1-a"
network_tags        = ["kalby-playground"]
subnetwork_project  = "sre-labs-220713" #project_id where the vpc_id resides
subnetwork_name     = "sre-test"        #subnet_id within the given vpc_id
path_ssh_pubkey     = "/Users/kalbyimanie/.ssh/id_rsa.pub"
ssh_user            = "kalbyimanie"
network_tier        = "STANDARD"
startup_script      = "startup.sh.tpl"




labels = {
  name = "kalby-playground"
}
