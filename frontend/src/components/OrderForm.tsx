import React, { useState, useEffect } from 'react';
import { Order, OrderCreate, OrderUpdate } from '../types/Order';

interface OrderFormProps {
  order?: Order;
  onSubmit: (data: OrderCreate | OrderUpdate) => void;
  onCancel: () => void;
  isLoading?: boolean;
}

const OrderForm: React.FC<OrderFormProps> = ({ order, onSubmit, onCancel, isLoading }) => {
  const [orderData, setOrderData] = useState('');

  useEffect(() => {
    if (order) {
      setOrderData(order.OrderData);
    }
  }, [order]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (orderData.trim()) {
      onSubmit({ OrderData: orderData.trim() });
    }
  };

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-lg shadow-xl p-6 w-full max-w-md">
        <h2 className="text-xl font-bold text-gray-900 mb-4">
          {order ? 'Edit Order' : 'Create New Order'}
        </h2>

        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label htmlFor="orderData" className="block text-sm font-medium text-gray-700 mb-2">
              Order Details
            </label>
            <textarea
              id="orderData"
              value={orderData}
              onChange={(e) => setOrderData(e.target.value)}
              rows={4}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              placeholder="Enter order details..."
              required
            />
          </div>

          <div className="flex gap-3">
            <button
              type="submit"
              disabled={isLoading || !orderData.trim()}
              className="flex-1 bg-blue-600 hover:bg-blue-700 disabled:bg-gray-400 text-white px-4 py-2 rounded-md text-sm font-medium transition-colors"
            >
              {isLoading ? 'Saving...' : (order ? 'Update' : 'Create')}
            </button>
            <button
              type="button"
              onClick={onCancel}
              disabled={isLoading}
              className="flex-1 bg-gray-600 hover:bg-gray-700 disabled:bg-gray-400 text-white px-4 py-2 rounded-md text-sm font-medium transition-colors"
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default OrderForm;