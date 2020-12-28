terraform {
  backend "s3" {
    bucket = "shonansurvivors-tfstate"
    key    = "stns-backend/demo/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
