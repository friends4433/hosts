provider "aws" {
    access_key = "AKIATF3V2G6G72IVSP45"
    secret_key = "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"
    region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "gvfxbucket02"
    key    = "Pipeline.tfstate"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"

  }
}


data "aws_ami" "my_ami" {
     most_recent      = true
     #name_regex       = "^mavrick"
     owners           = ["721834156908"]
}


resource "aws_instance" "web-1" {
    ami = "${data.aws_ami.my_ami.id}"
    #ami = "ami-0d857ff0f5fc4e03b"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "Desktop-Kye"
    subnet_id = "subnet-01f9c2774277f4015"
	private_ip = "10.1.1.111"
    vpc_security_group_ids = ["sg-09c2fc6ae1a93c80e"]
    associate_public_ip_address = true	
    tags = {
        Name = "Server-1"
        Env = "Prod"
        Owner = "Sree"
    }
}
