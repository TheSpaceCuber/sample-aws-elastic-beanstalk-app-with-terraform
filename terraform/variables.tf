variable "vpc_cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_public_cidr_blocks" {
    type = list(string)
    default = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "vpc_azs" {
    type = list(string)
    default = ["ap-southeast-1a", "ap-southeast-1b"]
}