from fastapi import FastAPI
from dotenv import load_dotenv
from app.routes.orders import router as orders_router

load_dotenv()

app = FastAPI(
    title="Orders Management API",
    description="A RESTful API for managing orders with CRUD operations",
    version="1.0.0"
)

app.include_router(orders_router, prefix="/api/v1")

@app.get("/")
def read_root():
    return {"message": "Orders Management API", "version": "1.0.0"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)