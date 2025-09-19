import React, { useState, useEffect } from 'react';
import { Order, OrderCreate, OrderUpdate } from '../types/Order';
import { orderApi } from '../services/orderApi';
import OrderCard from './OrderCard';
import OrderForm from './OrderForm';

const OrderList: React.FC = () => {
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [editingOrder, setEditingOrder] = useState<Order | undefined>();
  const [formLoading, setFormLoading] = useState(false);

  useEffect(() => {
    loadOrders();
  }, []);

  const loadOrders = async () => {
    try {
      setLoading(true);
      setError(null);
      const data = await orderApi.getOrders();
      setOrders(data);
    } catch (err) {
      setError('Failed to load orders');
      console.error('Error loading orders:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleCreateOrder = async (orderData: OrderCreate) => {
    try {
      setFormLoading(true);
      const newOrder = await orderApi.createOrder(orderData);
      setOrders([newOrder, ...orders]);
      setShowForm(false);
    } catch (err) {
      setError('Failed to create order');
      console.error('Error creating order:', err);
    } finally {
      setFormLoading(false);
    }
  };

  const handleUpdateOrder = async (orderData: OrderUpdate) => {
    if (!editingOrder) return;

    try {
      setFormLoading(true);
      const updatedOrder = await orderApi.updateOrder(editingOrder.OrderId, orderData);
      setOrders(orders.map(order =>
        order.OrderId === editingOrder.OrderId ? updatedOrder : order
      ));
      setEditingOrder(undefined);
      setShowForm(false);
    } catch (err) {
      setError('Failed to update order');
      console.error('Error updating order:', err);
    } finally {
      setFormLoading(false);
    }
  };

  const handleDeleteOrder = async (orderId: number) => {
    if (!window.confirm('Are you sure you want to delete this order?')) {
      return;
    }

    try {
      await orderApi.deleteOrder(orderId);
      setOrders(orders.filter(order => order.OrderId !== orderId));
    } catch (err) {
      setError('Failed to delete order');
      console.error('Error deleting order:', err);
    }
  };

  const handleEditOrder = (order: Order) => {
    setEditingOrder(order);
    setShowForm(true);
  };

  const handleCloseForm = () => {
    setShowForm(false);
    setEditingOrder(undefined);
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  return (
    <div className="max-w-6xl mx-auto px-6">
      <div className="flex justify-between items-center mb-8">
        <div>
          <h2 className="text-2xl font-bold text-gray-900">All Orders</h2>
          <p className="text-gray-600 mt-1">{orders.length} order{orders.length !== 1 ? 's' : ''} total</p>
        </div>
        <button
          onClick={() => setShowForm(true)}
          className="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-md font-medium transition-colors shadow-sm"
        >
          Create New Order
        </button>
      </div>

      {error && (
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
          {error}
          <button
            onClick={() => setError(null)}
            className="float-right font-bold"
          >
            ×
          </button>
        </div>
      )}

      {orders.length === 0 ? (
        <div className="text-center py-12">
          <div className="text-gray-500 text-lg mb-4">No orders found</div>
          <button
            onClick={() => setShowForm(true)}
            className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-md font-medium transition-colors"
          >
            Create your first order
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {orders.map((order) => (
            <OrderCard
              key={order.OrderId}
              order={order}
              onEdit={handleEditOrder}
              onDelete={handleDeleteOrder}
            />
          ))}
        </div>
      )}

      {showForm && (
        <OrderForm
          order={editingOrder}
          onSubmit={editingOrder ? handleUpdateOrder : handleCreateOrder}
          onCancel={handleCloseForm}
          isLoading={formLoading}
        />
      )}
    </div>
  );
};

export default OrderList;