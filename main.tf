# Cloud Run Service
resource "google_cloud_run_service" "chatbot" {
  name     = "chatbot-automated"
  location = var.LOCATION

  template {
    spec {
      containers {
        image = google_cloud_run_service.chatbot.latest_created_revision
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Cloud Build Step to Build and Deploy to Cloud Run
resource "google_cloudbuild_build" "build_and_deploy" {
  project = var.project_id

  steps {
    name = "gcr.io/cloud-builders/gcloud"
    args = ["run", "deploy", "chatbot-automated",
            "--source", "./Frontend/",
            "--region", var.LOCATION,
            "--allow-unauthenticated"]
  }

  timeout = "1200s"
}

# IAM Policy to Allow Public Access
resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.chatbot.name
  location = google_cloud_run_service.chatbot.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}