terraform {
  backend "gcs" {
    bucket  = "terraform-449407"
    prefix  = "state"
  }
}