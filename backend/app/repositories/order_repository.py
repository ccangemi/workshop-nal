from sqlalchemy.orm import Session
from sqlalchemy.exc import SQLAlchemyError
from typing import List, Optional
from app.models.order import Order, OrderCreate, OrderUpdate

class OrderRepository:
    def __init__(self, db: Session):
        self.db = db

    def create_order(self, order_data: OrderCreate) -> Order:
        try:
            db_order = Order(OrderData=order_data.OrderData)
            self.db.add(db_order)
            self.db.commit()
            self.db.refresh(db_order)
            return db_order
        except SQLAlchemyError as e:
            self.db.rollback()
            raise e

    def get_order(self, order_id: int) -> Optional[Order]:
        return self.db.query(Order).filter(Order.OrderId == order_id).first()

    def get_orders(self, skip: int = 0, limit: int = 100) -> List[Order]:
        return self.db.query(Order).order_by(Order.OrderId).offset(skip).limit(limit).all()

    def get_orders_count(self) -> int:
        return self.db.query(Order).count()

    def update_order(self, order_id: int, order_data: OrderUpdate) -> Optional[Order]:
        try:
            db_order = self.db.query(Order).filter(Order.OrderId == order_id).first()
            if db_order:
                db_order.OrderData = order_data.OrderData
                self.db.commit()
                self.db.refresh(db_order)
                return db_order
            return None
        except SQLAlchemyError as e:
            self.db.rollback()
            raise e

    def delete_order(self, order_id: int) -> bool:
        try:
            db_order = self.db.query(Order).filter(Order.OrderId == order_id).first()
            if db_order:
                self.db.delete(db_order)
                self.db.commit()
                return True
            return False
        except SQLAlchemyError as e:
            self.db.rollback()
            raise e