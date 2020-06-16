# Globus Connect Server
  
## Quickstart
Create a `.env` file with necessary info for Globus.
You can copy the `.env-sample` file -> `.env` and modify with your information.
```
mkdir -p ./data
docker build -t globus-server .
docker run --env-file .env globus-server
```

