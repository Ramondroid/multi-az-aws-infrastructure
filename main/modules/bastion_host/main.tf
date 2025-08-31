data "aws_ami" "amazon_linux_2" {
    most_recent = var.data_most_recent
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    owners = ["amazon"] # Amazon
}

resource "aws_instance" "bastion" {
    ami           = data.aws_ami.amazon_linux_2.id
    instance_type = var.bastion_confi.instance_type
    key_name      = var.bastion_confi.key_name
    subnet_id     = var.subnet_id
    vpc_security_group_ids = var.security_group_ids
    associate_public_ip_address = var.bastion_public_enable
    tags = { Name = "${var.project_code["ProjectCode"]}-bastion-host"}
}