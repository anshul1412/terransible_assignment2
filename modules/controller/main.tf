provider "aws" {
    region = "us-east-1"
}

resource "tls_private_key" "rsa" {
    
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "tf-key-pair" {
    
    key_name = "ansible-controller-pair"
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "tf-key" {
    
    content  = tls_private_key.rsa.private_key_pem
    filename = "ansible-controller-pair"
}

resource "aws_instance" "ansible_controller" {
    #default controller variable is false(0). so this resource block will not run if the condition is true
   
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    key_name = "ansible-controller-pair"

    user_data = <<-EOF
    #!/bin/bash
    echo "updating APT"
    sudo apt update
    echo "install ansible"
    sudo apt install ansible
    echo "install python"
    sudo apt install python3.10
    sudo hostnamectl set-hostname ANSIBLE-CONTROLLER
    EOF
    #Why is it dafailing if I keep it as a seperate block? 
    provisioner "file" {
    source = "home/ubuntu/ip_address.txt"
    destination = "home/ubuntu/ip_address.txt"
}
}

#This provisioner will copy the file containng private IP made from controllers to local and then local to controller
#provisioner "file" {
#    source = "home/ubuntu/ip_address.txt"
#    destination = "home/ubuntu/ip_address.txt"
#}
