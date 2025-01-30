#!/bin/bash

# Purpose: To deploy the App to Cloud Run.

# Google Cloud Project
PROJECT=webinar-449407

# Google Cloud Region
LOCATION=europe-west1

# Depolying app from source code
gcloud run deploy chatbot --source . --region=$LOCATION --project=$PROJECT --allow-unauthenticated