export interface Order {
  OrderId: number;
  OrderData: string;
  CreatedAt: string;
}

export interface OrderCreate {
  OrderData: string;
}

export interface OrderUpdate {
  OrderData: string;
}