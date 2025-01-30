terraform {
  backend "gcs" {
    bucket  = var.BACKEND_BUCKET
    prefix  = "state"
  }
}