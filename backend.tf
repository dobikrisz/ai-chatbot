terraform {
  backend "gcs" {
    bucket  = "webinar-449407"
    prefix  = "state"
  }
}