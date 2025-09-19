# Orders Management Frontend

A modern React TypeScript application for managing orders with full CRUD operations.

## Features

- **Modern UI**: Clean, responsive design with Tailwind CSS
- **Full CRUD Operations**: Create, Read, Update, Delete orders
- **Real-time Updates**: Instant UI updates after operations
- **Error Handling**: Comprehensive error handling and user feedback
- **TypeScript**: Full type safety throughout the application
- **Responsive Design**: Works perfectly on desktop and mobile devices

## Technologies Used

- **React 18** with TypeScript
- **Tailwind CSS** for styling
- **Axios** for API communication
- **Modern React Hooks** for state management

## Prerequisites

- Node.js (v14 or higher)
- npm or yarn
- Backend API running on `http://localhost:8000`

## Installation

1. Install dependencies:
```bash
npm install
```

2. Configure environment variables:
```bash
# .env file (for development - already configured)
REACT_APP_API_URL=http://localhost:8000
```

**Note**: For Docker deployments, use the `API_URL` environment variable at runtime (see Docker section below).

## Running the Application

### Development Mode
```bash
npm start
```
Opens [http://localhost:3000](http://localhost:3000) in your browser.

### Production Build
```bash
npm run build
```
Builds the app for production to the `build` folder.

### Docker Container

#### Build and Run with Docker
```bash
# Build the Docker image
docker build -t workshop-frontend .

# Run with default API URL (http://localhost:8000)
docker run -d -p 3000:80 --name workshop-frontend workshop-frontend

# Run with custom API URL using environment variable
docker run -d -p 3000:80 -e API_URL="http://your-api-server:8000" --name workshop-frontend workshop-frontend
```

**Environment Variables for Docker:**
- `API_URL`: Backend API URL (default: `http://localhost:8000`)

The API URL can be configured at runtime without rebuilding the container.

#### Stop and Remove Container
```bash
docker stop workshop-frontend
docker rm workshop-frontend
```

The containerized frontend will be available at [http://localhost:3000](http://localhost:3000).

## API Integration

The frontend connects to the FastAPI backend with the following endpoints:

- `GET /api/v1/orders/` - Fetch all orders
- `POST /api/v1/orders/` - Create new order
- `GET /api/v1/orders/{id}` - Get specific order
- `PUT /api/v1/orders/{id}` - Update order
- `DELETE /api/v1/orders/{id}` - Delete order

## Usage

1. **Starting the App**: Ensure the backend is running, then start the frontend
2. **Creating Orders**: Click "Create New Order" and fill in the details
3. **Editing Orders**: Click "Edit" on any order card to modify
4. **Deleting Orders**: Click "Delete" and confirm to remove orders
5. **Viewing Orders**: All orders are displayed in a responsive grid

## Workshop Context

This frontend is part of a Kubernetes/OpenShift workshop demonstrating modern web application development and container deployment patterns.