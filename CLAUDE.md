# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a comprehensive Kubernetes/OpenShift workshop repository featuring a complete containerized application stack. The project demonstrates modern web development practices with a focus on container orchestration and cloud-native deployment patterns.

## Architecture

The application consists of three main components:
- **Frontend**: React TypeScript SPA with responsive design
- **Backend**: Python FastAPI REST API with CRUD operations
- **Database**: MariaDB with persistent storage

All components are fully containerized and configured for Kubernetes/OpenShift deployment.

## Project Structure

```
workshop/
├── backend/                 # Python FastAPI backend
│   ├── app/                # Application modules
│   │   ├── config/         # Database configuration with MariaDB support
│   │   ├── models/         # SQLAlchemy data models
│   │   ├── repositories/   # Data access layer
│   │   └── routes/         # API route handlers with CRUD operations
│   ├── main.py             # Application entry point with CORS middleware
│   ├── Dockerfile          # Multi-stage container build
│   ├── requirements.txt    # Python dependencies including FastAPI, SQLAlchemy
│   ├── .env.example        # Environment variables template
│   └── README.md          # Backend documentation with MariaDB setup
├── frontend/               # React TypeScript frontend
│   ├── src/               # Source code
│   │   ├── components/    # React components (OrderList, OrderCard, OrderForm, Header)
│   │   ├── services/      # API integration with runtime configuration
│   │   ├── types/         # TypeScript interfaces for Order entities
│   │   └── index.css      # Custom CSS utilities (Tailwind-inspired)
│   ├── public/            # Static assets including runtime config
│   ├── Dockerfile         # Multi-stage build with Nginx serving
│   ├── docker-entrypoint.sh # Runtime configuration script
│   ├── nginx.conf         # Nginx configuration with React Router support
│   ├── package.json       # Node.js dependencies
│   └── README.md         # Frontend documentation with Docker instructions
├── imgs/                  # Workshop images and assets
├── .gitignore            # Comprehensive gitignore for all technologies
├── CLAUDE.md             # This file - AI assistant instructions
└── README.md             # Main project documentation with complete setup
```

## Key Technologies

### Backend (FastAPI)
- **Framework**: FastAPI with automatic OpenAPI documentation
- **Database**: SQLAlchemy ORM with MariaDB/MySQL support
- **Security**: CORS middleware configured for browser compatibility
- **Architecture**: Repository pattern with separation of concerns
- **Configuration**: Environment-based configuration
- **Containerization**: Docker with Python 3.11-slim base image

### Frontend (React)
- **Framework**: React 18 with TypeScript for type safety
- **Styling**: Custom CSS utilities inspired by Tailwind
- **API Integration**: Axios with runtime-configurable endpoints
- **State Management**: React hooks for local state
- **Build**: Create React App with production optimizations
- **Serving**: Nginx with optimized configuration
- **Configuration**: Runtime environment variable support

### Database
- **Engine**: MariaDB latest with persistent volumes
- **Schema**: Orders table with auto-increment ID and timestamps
- **Initialization**: SQL scripts for table creation and sample data
- **Connection**: MySQL+PyMySQL driver for Python integration

## Development Workflow

### Local Development
- Backend: Python virtual environment with FastAPI dev server
- Frontend: Node.js with hot reload development server
- Database: Local MariaDB or Docker container

### Container Development
- All services containerized with Docker
- Multi-stage builds for optimized production images
- Environment variable configuration for different environments
- Health checks and proper signal handling

### Key Environment Variables

**Backend:**
- `DATABASE_CONNECTION_STRING`: Database connection (required)

**Frontend:**
- `API_URL`: Backend API endpoint (runtime configurable)
- `REACT_APP_API_URL`: Build-time API endpoint (development fallback)

## Container Commands

### Complete Stack Startup
```bash
# Database
docker run -d --name mariadb-workshop -e MYSQL_ROOT_PASSWORD=workshop123 -e MYSQL_DATABASE=orders_db -e MYSQL_USER=workshop -e MYSQL_PASSWORD=workshop123 -p 3306:3306 mariadb:latest

# Backend
docker build -t workshop-backend ./backend
docker run -d -p 8000:8000 -e DATABASE_CONNECTION_STRING="mysql+pymysql://workshop:workshop123@host.docker.internal:3306/orders_db" --name workshop-app workshop-backend

# Frontend
docker build -t workshop-frontend ./frontend
docker run -d -p 3000:80 -e API_URL="http://localhost:8000" --name workshop-frontend workshop-frontend
```

## API Endpoints

- `GET /` - Root endpoint with API information
- `GET /health` - Health check endpoint
- `GET /docs` - Swagger UI documentation
- `GET /api/v1/orders/` - List orders with pagination
- `POST /api/v1/orders/` - Create new order
- `GET /api/v1/orders/{id}` - Get specific order
- `PUT /api/v1/orders/{id}` - Update order
- `DELETE /api/v1/orders/{id}` - Delete order

## Workshop Focus

This repository demonstrates:

1. **Microservices Architecture**: Separate frontend, backend, and database services
2. **Container Best Practices**: Multi-stage builds, proper base images, security
3. **Configuration Management**: Environment variables, runtime configuration
4. **Database Integration**: ORM patterns, migrations, persistent storage
5. **Modern Frontend**: TypeScript, responsive design, API integration
6. **DevOps Practices**: Docker, health checks, logging, monitoring
7. **Cloud-Native Patterns**: 12-factor app principles, stateless design

## Kubernetes/OpenShift Resources

- OpenShift CLI: https://developers.redhat.com/learning/learn:openshift:download-and-install-red-hat-openshift-cli/resource/resources:download-and-install-oc
- OpenShift Console: https://console.ocp4azexp2.cloudsvil.poste.it/

## Development Notes

When working with this repository:

1. **Always check container logs** for debugging issues
2. **Use environment variables** for configuration rather than hardcoding
3. **Follow the repository patterns** for consistency
4. **Test full stack integration** when making changes
5. **Document any new features** in appropriate README files
6. **Maintain Docker best practices** for security and efficiency

The project is designed to be a comprehensive example of modern cloud-native application development suitable for Kubernetes/OpenShift deployment.