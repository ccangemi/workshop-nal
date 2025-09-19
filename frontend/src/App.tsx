import React from 'react';
import Header from './components/Header';
import OrderList from './components/OrderList';

function App() {
  return (
    <div className="min-h-screen bg-gray-50">
      <Header />
      <main className="py-8">
        <OrderList />
      </main>
    </div>
  );
}

export default App;
