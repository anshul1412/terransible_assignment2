# This file will capture the output of private IP of created target machines
output "target_ip"{
    value = aws_instance.ansible_target.*.private_ip
}
