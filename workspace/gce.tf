/*
Pointers
- terraform workspace -h
- terraform workspace show
- terraform workspace new dev
- terraform workspace show
- terraform workspace new prod
- terraform workspace list
- '*' indicates current workspace
- Create the code and show terraform plan by switching to different workspaces
- Terraform apply and then show terraform.tfstate.d
- Default workspace tfstate file will be created in root directory
- Do terraform apply and show
*/

provider "google" {
  project = "learning-terraform-363515"
  region  = "asia-south1"
  zone    = "asia-south1-a"
}

resource "google_compute_instance" "vm_instance" {
  name         = "demo-terraform-instance"
  machine_type = lookup(var.instance_type,terraform.workspace)
  labels = {owner = "mohit-parikh"}

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-bionic-v20220810"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "learning-terraform"
    subnetwork = "demo-subnet"
    access_config {
    }
  }
}

variable "instance_type" {
  type = map
  default = {
    default = "e2-micro"
    dev = "e2-medium"
    prod = "e2-large"
  }

}