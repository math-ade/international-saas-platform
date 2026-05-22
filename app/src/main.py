from fastapi import FastAPI
from prometheus_client import make_asgi_app, Counter
import socket

app = FastAPI(title="GlobalSaaS-ProductionAPI")

metrics_app = make_asgi_app()
app.mount("/metrics", metrics_app)

REQUEST_COUNTER = Counter("saas_api_requests_total", "Total requests served", ["endpoint", "node"])

@app.get("/api/v1/data")
async def get_data():
    node_ip = socket.gethostbyname(socket.gethostname())
    REQUEST_COUNTER.labels(endpoint="data", node=node_ip).inc()
    return {
        "status": "success",
        "infra_tier": "multi-tenant-cluster",
        "execution_engine": "podman-native-k8s",
        "serving_node_ip": node_ip
    }

@app.get("/healthz")
def health_check():
    return {"status": "healthy"}
