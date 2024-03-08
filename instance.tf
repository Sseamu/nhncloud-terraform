data "nhncloud_compute_flavor_v2" "m2c1m2"{
  name = "m2.c1m2"
}

data "nhncloud_images_image_v2" "ubuntu_2004_20240220" {
  name = "Ubuntu Server 20.04.6 LTS (2024.02.20)"
  most_recent = true
}

resource "nhncloud_compute_instance_v2" "hansom_terraform_instance"{
  name = "tf_hansom_instance_01"
  region    = "KR1"
  key_pair  = var.key_name
  image_id = data.nhncloud_images_image_v2.ubuntu_2004_20240220.id
  flavor_id = data.nhncloud_compute_flavor_v2.m2c1m2.id
  security_groups = ["default"]
  availability_zone = "kr-pub-a"

  network {
    name = nhncloud_networking_vpc_v2.hansom-vpc.name
    uuid = nhncloud_networking_vpc_v2.hansom-vpc.id
    port = nhncloud_networking_port_v2.port_container.id
  }

  block_device {
    uuid = data.nhncloud_images_image_v2.ubuntu_2004_20240220.id
    source_type = "image"
    destination_type = "volume"
    boot_index = 0
    delete_on_termination = true
    volume_size = 30
  }
}


