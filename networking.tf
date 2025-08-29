module "tgw_gwlb" {

    source  = "CheckPointSW/cloudguard-network-security/aws//modules/tgw_gwlb_master"
    version = "1.0.3"

    // --- VPC Network Configuration --
    vpc_cidr = "10.100.0.0/16"
    public_subnets_map = {
     "us-east-1a" = 1
     "us-east-1b" = 2
    }
    tgw_subnets_map = {
     "us-east-1a" = 5
     "us-east-1b" = 6
    }
    subnets_bit_length = 8

    availability_zones = ["us-east-1a", "us-east-1b"]
    number_of_AZs = 2

    nat_gw_subnet_1_cidr ="10.100.13.0/24"
    nat_gw_subnet_2_cidr = "10.100.23.0/24"

    gwlbe_subnet_1_cidr = "10.100.14.0/24"
    gwlbe_subnet_2_cidr = "10.100.24.0/24"

    // --- General Settings ---
    key_name = "publickey"
    enable_volume_encryption = true
    volume_size = 100
    enable_instance_connect = false
    disable_instance_termination = false
    allow_upload_download = true
    management_server = "lab-management-tf"
    configuration_template = "lab-template-tf"
    admin_shell = "/etc/cli.sh"

    // --- Gateway Load Balancer Configuration ---
    gateway_load_balancer_name = "lab-gwlb"
    target_group_name = "lab-target-group"
    enable_cross_zone_load_balancing = "true"

    // --- Check Point CloudGuard IaaS Security Gateways Auto Scaling Group Configuration ---
    gateway_name = "lab-gateways-tf"
    gateway_instance_type = "c5.xlarge"
    minimum_group_size = 2
    maximum_group_size = 4
    gateway_version = "R81.20-BYOL"
    gateway_password_hash = ""
    gateway_maintenance_mode_password_hash = "" # For R81.10 and below the gateway_password_hash is used also as maintenance-mode password.
    gateway_SICKey = var.sic_key
    gateways_provision_address_type = "private"
    allocate_public_IP = false
    enable_cloudwatch = false
    gateway_bootstrap_script = "echo 'this is bootstrap script' > /home/admin/bootstrap.txt"

    // --- Check Point CloudGuard IaaS Security Management Server Configuration ---
    management_deploy = true
    management_instance_type = "m5.xlarge"
    management_version = "R81.20-BYOL"
    management_password_hash = ""
    management_maintenance_mode_password_hash = "" # For R81.10 and below the management_password_hash is used also as maintenance-mode password.
    gateways_policy = "Standard"
    gateway_management = "Locally managed"
    admin_cidr = "0.0.0.0/0"
    gateways_addresses = "0.0.0.0/0"

    // --- Other parameters ---
    volume_type = "gp3"

 }
