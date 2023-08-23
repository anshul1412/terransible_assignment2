# taronly is boolean for deciding to create the target or controller machine
# I added controller and target variables in the respective module's variable.tf files
module "controller" {
        controller = var.taronly ? 1 : 0 
        source = "../modules/controller"
        #controller = var.taronly
}

module "target" {
        #policy = var.devuser ? module.IamPolicyDev.policy : module.IamPolicyQA.policy
        target = var.taronly ? 1 : 0 
        number_target = var.num
        #target = var.taronly
        source = "../modules/target"
}
