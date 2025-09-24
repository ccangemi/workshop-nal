from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from app.config.database import get_db
from app.models.order import OrderCreate, OrderUpdate, OrderResponse
from app.repositories.order_repository import OrderRepository
from app.metrics import orders_created_total, orders_updated_total, orders_deleted_total, orders_total, update_orders_total_metric

router = APIRouter(prefix="/orders", tags=["orders"])

@router.post("/", response_model=OrderResponse, status_code=status.HTTP_201_CREATED)
def create_order(order: OrderCreate, db: Session = Depends(get_db)):
    repository = OrderRepository(db)
    try:
        db_order = repository.create_order(order)
        orders_created_total.inc()
        # Update total orders count
        update_orders_total_metric(db)
        return db_order
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to create order: {str(e)}"
        )

@router.get("/", response_model=List[OrderResponse])
def get_orders(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    repository = OrderRepository(db)
    orders = repository.get_orders(skip=skip, limit=limit)
    # Update total orders count
    update_orders_total_metric(db)
    return orders

@router.get("/{order_id}", response_model=OrderResponse)
def get_order(order_id: int, db: Session = Depends(get_db)):
    repository = OrderRepository(db)
    db_order = repository.get_order(order_id)
    if db_order is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Order not found"
        )
    return db_order

@router.put("/{order_id}", response_model=OrderResponse)
def update_order(order_id: int, order: OrderUpdate, db: Session = Depends(get_db)):
    repository = OrderRepository(db)
    try:
        db_order = repository.update_order(order_id, order)
        if db_order is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Order not found"
            )
        orders_updated_total.inc()
        return db_order
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update order: {str(e)}"
        )

@router.delete("/{order_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_order(order_id: int, db: Session = Depends(get_db)):
    repository = OrderRepository(db)
    try:
        success = repository.delete_order(order_id)
        if not success:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Order not found"
            )
        orders_deleted_total.inc()
        # Update total orders count
        update_orders_total_metric(db)
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to delete order: {str(e)}"
        )