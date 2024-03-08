resource "nhncloud_networking_vpc_v2" "hansom-vpc" {
  name = "hansom-vpc"
  cidrv4 = "10.0.0.0/16"
}
//public 서브넷 생성 
resource "nhncloud_networking_vpcsubnet_v2" "hansom-vpcsubnet-pub" {
  name      = "tf-vpcsubnet-public"
  vpc_id    = nhncloud_networking_vpc_v2.hansom-vpc.id
  routingtable_id = nhncloud_networking_routingtable_v2.resource-rt-pub.id
  // public rt에 연결 
  cidr      = "10.0.0.0/24"
}
// Private 서브넷 생성
resource "nhncloud_networking_vpcsubnet_v2" "hansom-vpcsubnet-private" {
  name      = "tf-vpcsubnet-private"
  vpc_id    = nhncloud_networking_vpc_v2.hansom-vpc.id
  routingtable_id = nhncloud_networking_routingtable_v2.resource-rt-private.id 
  //private rt에 연결
  cidr      = "10.0.1.0/24"
}

// Public Routing table
resource "nhncloud_networking_routingtable_v2" "resource-rt-pub" {
  name = "resource-rt-pub"
  vpc_id = nhncloud_networking_vpc_v2.hansom-vpc.id
  distributed = false
}
// Private Routing table
resource "nhncloud_networking_routingtable_v2" "resource-rt-private" {
  name = "resource-rt-private"
  vpc_id = nhncloud_networking_vpc_v2.hansom-vpc.id
  distributed = false
}


//컨테이너와 통신하기위해 뚫어놓는 포트 
resource "nhncloud_networking_port_v2" "port_container" {
  name = "tf_port_container"
  network_id = nhncloud_networking_vpc_v2.hansom-vpc.id
  admin_state_up = "true"
  depends_on = [
    nhncloud_networking_vpcsubnet_v2.hansom-vpcsubnet-pub,
    nhncloud_networking_vpcsubnet_v2.hansom-vpcsubnet-private
  ]
}