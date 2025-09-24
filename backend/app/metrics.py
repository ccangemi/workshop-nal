from prometheus_client import Counter, Histogram, Gauge, generate_latest, CONTENT_TYPE_LATEST
import time
import psutil
import os

# HTTP request metrics
http_requests_total = Counter(
    'http_requests_total',
    'Total number of HTTP requests',
    ['method', 'endpoint', 'status_code']
)

http_request_duration_seconds = Histogram(
    'http_request_duration_seconds',
    'HTTP request duration in seconds',
    ['method', 'endpoint']
)

# Application metrics
active_connections = Gauge(
    'active_connections',
    'Number of active connections'
)

# System metrics
cpu_usage_percent = Gauge(
    'cpu_usage_percent',
    'CPU usage percentage'
)

memory_usage_bytes = Gauge(
    'memory_usage_bytes',
    'Memory usage in bytes'
)

# Business metrics
orders_total = Gauge(
    'orders_total',
    'Total number of orders in the system'
)

orders_created_total = Counter(
    'orders_created_total',
    'Total number of orders created'
)

orders_updated_total = Counter(
    'orders_updated_total',
    'Total number of orders updated'
)

orders_deleted_total = Counter(
    'orders_deleted_total',
    'Total number of orders deleted'
)

def update_orders_total_metric(db_session):
    """Update orders_total metric with current count from database"""
    try:
        from app.repositories.order_repository import OrderRepository
        repository = OrderRepository(db_session)
        total_orders = repository.get_orders_count()
        orders_total.set(total_orders)
    except Exception:
        # Ignore errors in metrics collection
        pass

def update_system_metrics():
    """Update system metrics with current values"""
    try:
        # CPU usage
        cpu_percent = psutil.cpu_percent(interval=None)
        cpu_usage_percent.set(cpu_percent)

        # Memory usage
        process = psutil.Process(os.getpid())
        memory_info = process.memory_info()
        memory_usage_bytes.set(memory_info.rss)

    except Exception:
        # Ignore errors in metrics collection
        pass

def get_metrics():
    """Generate and return metrics in OpenMetrics format"""
    update_system_metrics()
    # Also try to update orders_total when metrics are requested
    try:
        from app.config.database import db_config
        db = next(db_config.get_db())
        try:
            update_orders_total_metric(db)
        finally:
            db.close()
    except Exception:
        # Ignore errors - metrics collection should not fail the request
        pass
    return generate_latest()

def get_content_type():
    """Return the correct content type for OpenMetrics"""
    return CONTENT_TYPE_LATEST