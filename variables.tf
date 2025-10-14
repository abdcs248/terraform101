variable "ec2_instance_type" {
  default = "t3.micro"
  type = string
}

variable "ec2_root_storage_size" {
  default = 15
  type = number
}
 
 variable "ec2_ami_id" {
    default = "ami-0a716d3f3b16d290c"
    type = string
  
}