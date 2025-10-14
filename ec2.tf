#key pair

resource "aws_key_pair" "my_key" {

    key_name = "key-for-terraform"
    public_key = file("key-for-terraform.pub")
  
}

#vpc & security group

resource "aws_default_vpc" "default"{

}

resource "aws_security_group" "my_security_group" {
    name = "sample-sg"
    description = "This will add some security rules."
    vpc_id = aws_default_vpc.default.id

    #rules

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH open"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP open"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All outbound traffic."
    }

    tags = {
        Name = "terra-sg"
    }
}

# ec2 instance

resource "aws_instance" "my_instance" {

    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = var.ec2_instance_type
    ami = var.ec2_ami_id
     user_data = file("install_nginx.sh")

    root_block_device {
      volume_size = var.ec2_root_storage_size
      volume_type = "gp3"
    }

    tags = {
     Name = "First-ec2-with-terraform." 
    }
  
}