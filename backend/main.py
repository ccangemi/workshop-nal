import os
# Disable Prometheus _created metrics before any prometheus imports
os.environ['PROMETHEUS_DISABLE_CREATED_SERIES'] = 'True'

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import Response
from dotenv import load_dotenv
import logging
from app.routes.orders import router as orders_router
from app.metrics import get_metrics, get_content_type, update_orders_total_metric
from app.middleware.metrics_middleware import MetricsMiddleware
from app.config.database import db_config

load_dotenv()

app = FastAPI(
    title="Orders Management API",
    description="A RESTful API for managing orders with CRUD operations",
    version="1.0.0"
)

# Define the filter
class EndpointFilter(logging.Filter):
    def filter(self, record: logging.LogRecord) -> bool:
        return record.args and len(record.args) >= 3 and record.args[2] != "/health" and record.args[2] != "/metrics"

# Add filter to the logger
logging.getLogger("uvicorn.access").addFilter(EndpointFilter())

# Configure middlewares
app.add_middleware(MetricsMiddleware)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins
    allow_credentials=False,  # Must be False when using allow_origins=["*"]
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("startup")
async def startup_event():
    """Initialize metrics on application startup"""
    try:
        db = next(db_config.get_db())
        try:
            update_orders_total_metric(db)
        finally:
            db.close()
    except Exception:
        # Don't fail startup if metrics initialization fails
        pass

app.include_router(orders_router, prefix="/api/v1")

@app.get("/")
def read_root():
    return {"message": "Orders Management API", "version": "1.0.0"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

@app.get("/metrics")
def metrics():
    """OpenMetrics endpoint for Prometheus scraping"""
    return Response(content=get_metrics(), media_type=get_content_type())

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)