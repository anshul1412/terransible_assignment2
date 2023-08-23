# creating the boolean variable for detrmining the TARGET or CONTROLLER creation
variable "taronly"{
    description = "if true, this plan will create only target machines"
    type = bool
    default = true
}


variable "num"{
    description = "number of ansible target machine creation"
    default = "1"
    # changing from 1 to "1" so that it can work with for_each
}

