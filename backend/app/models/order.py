from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime
from pydantic import BaseModel
from typing import Optional
from app.config.database import Base

class Order(Base):
    __tablename__ = "ORDERS"

    OrderId = Column(Integer, primary_key=True, index=True)
    OrderData = Column(String(500), nullable=False)
    CreatedAt = Column(DateTime, default=datetime.utcnow)

class OrderCreate(BaseModel):
    OrderData: str

class OrderUpdate(BaseModel):
    OrderData: str

class OrderResponse(BaseModel):
    OrderId: int
    OrderData: str
    CreatedAt: datetime

    class Config:
        from_attributes = True