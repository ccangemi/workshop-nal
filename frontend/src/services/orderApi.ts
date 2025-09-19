import axios from 'axios';
import { Order, OrderCreate, OrderUpdate } from '../types/Order';

// Get API URL from runtime config or fallback to environment variable or default
const getApiUrl = (): string => {
  // Check for runtime config (available in browser)
  if (typeof window !== 'undefined' && (window as any).APP_CONFIG?.API_URL) {
    return (window as any).APP_CONFIG.API_URL;
  }
  // Fallback to build-time environment variable
  return process.env.REACT_APP_API_URL || 'http://localhost:8000';
};

const API_BASE_URL = getApiUrl();

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const orderApi = {
  // Get all orders
  getOrders: async (skip: number = 0, limit: number = 100): Promise<Order[]> => {
    const response = await api.get(`/api/v1/orders/`, {
      params: { skip, limit }
    });
    return response.data;
  },

  // Get single order
  getOrder: async (orderId: number): Promise<Order> => {
    const response = await api.get(`/api/v1/orders/${orderId}`);
    return response.data;
  },

  // Create new order
  createOrder: async (order: OrderCreate): Promise<Order> => {
    const response = await api.post('/api/v1/orders/', order);
    return response.data;
  },

  // Update order
  updateOrder: async (orderId: number, order: OrderUpdate): Promise<Order> => {
    const response = await api.put(`/api/v1/orders/${orderId}`, order);
    return response.data;
  },

  // Delete order
  deleteOrder: async (orderId: number): Promise<void> => {
    await api.delete(`/api/v1/orders/${orderId}`);
  },
};