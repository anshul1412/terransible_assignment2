provider "aws" {
    region = "us-east-1"
}

# within the loop for creating 2 target's I want to set the hostname as target1, target2 etc
# I did as follow but, not sure how I can pass the var.number_target, to the shell script in user_data block
# sudo hostnamectl set-hostname target($number_target) , this I added after pyhton installation

resource "aws_instance" "ansible_target" {
    for_each = toset(var.number_target)

    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    
    user_data = <<-EOF
    #!/bin/bash
    echo "updating APT"
    sudo apt update
    echo "install python"
    sudo apt install python3.10  
    EOF

    # Following will create and append the file ip_address.txt in my Main EC2 instance.
    # I'll copy this file using file provisioner in controller to have the list ready to make inventory file
    provisioner "local-exec" {
    command = "echo ${self.private_ip} >> home/ubuntu/ip_address.txt"  
  }
}
