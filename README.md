# ai-chatbot
A simple AI chatbot hosted on GCP and powered by vertex AI

## Run locally:

```
pip install -r requirements
streamlit run Frontend.py -- --project_id=<PROJECT_ID>

```

## Deploy on Cloud Run:

```
PROJECT=PROJECT_ID>

# Google Cloud Region
LOCATION=<LOCATION>

touch Procfile
echo "web: streamlit run Frontend.py --server.port=8080 --server.address=0.0.0.0 --server.enableCORS=false --browser.gatherUsageStats=false -- --project_id=<PROJECT_ID>" > Procfile

# Depolying app from source code
gcloud run deploy chatbot --source . --region=$LOCATION --project=$PROJECT --allow-unauthenticated
```
