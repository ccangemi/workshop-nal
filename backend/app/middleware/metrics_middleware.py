import time
from fastapi import Request
from starlette.middleware.base import BaseHTTPMiddleware
from app.metrics import http_requests_total, http_request_duration_seconds

class MetricsMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        # Skip metrics collection for the metrics endpoint to avoid recursion
        if request.url.path == "/metrics":
            return await call_next(request)

        start_time = time.time()
        method = request.method
        endpoint = request.url.path

        response = await call_next(request)

        # Calculate duration
        duration = time.time() - start_time

        # Record metrics
        status_code = str(response.status_code)
        http_requests_total.labels(method=method, endpoint=endpoint, status_code=status_code).inc()
        http_request_duration_seconds.labels(method=method, endpoint=endpoint).observe(duration)

        return response