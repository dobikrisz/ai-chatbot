variable "PROJECT_ID" {
    type = string
    description = "GCP default project"
}

variable "LOCATION" {
    type = string
    description = "GCP default location"
}

variable "BACKEND_BUCKET" {
    type = string
    description = "Backend bucket for terraform state file"
}