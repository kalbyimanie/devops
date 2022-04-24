number_of_instances = 1
project_id          = "road-to-expert"
instance_name       = "vm-bastion"
image_name          = "ubuntu-1804-bionic-v20210817"
machine_type        = "custom-2-${2 * 1024}"
boot_disk_size      = 10
boot_disk_type      = "pd-standard"
extended_disk_size  = 10
extended_disk_type  = "pd-standard"
zone                = "asia-southeast1-a"
network_tags        = ["kalby-playground"]
subnetwork_project  = "road-to-expert"     #project_id where the vpc_id resides
subnetwork_name     = "rte-subnet-tools-1" #subnet_id within the given vpc_id
path_ssh_pubkey     = "/Users/kalbyimanie/.ssh/id_rsa.pub"
ssh_user            = "kalbyimanie"
network_tier        = "STANDARD"
startup_script      = "startup.sh.tpl"

labels = {
  name = "kalby-playground"
}
