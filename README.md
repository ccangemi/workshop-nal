# Kubernetes/OpenShift Workshop

A complete containerized application demonstrating modern web development practices with Kubernetes/OpenShift deployment capabilities.

## 🏗️ Architecture

This workshop features a full-stack application with:

- **Frontend**: React TypeScript SPA with modern UI
- **Backend**: Python FastAPI with CRUD operations
- **Database**: MariaDB with persistent data
- **Containerization**: Docker containers for all services
- **Orchestration**: Kubernetes/OpenShift ready

## 🚀 Quick Start

### Prerequisites
- Docker
- Basic understanding of containerization concepts

### Getting Started

1. **Clone the repository**
2. **Follow service-specific setup instructions:**
   - [`backend/README.md`](backend/README.md) - API service setup and configuration
   - [`frontend/README.md`](frontend/README.md) - Web interface setup and configuration
3. **Start services** as documented in each component's README

### Service Architecture

- **Frontend Service**: Modern web interface (port 3000)
- **Backend Service**: RESTful API (port 8000)
- **Database Service**: Persistent data storage (port 3306)

Each service can be run independently or as part of the complete stack.

## 📁 Project Structure

```
workshop/
├── backend/                 # Python FastAPI backend
│   ├── app/                # Application modules
│   │   ├── config/         # Database configuration
│   │   ├── models/         # Data models
│   │   ├── repositories/   # Data access layer
│   │   └── routes/         # API endpoints
│   ├── Dockerfile          # Backend container config
│   ├── requirements.txt    # Python dependencies
│   └── README.md          # Backend documentation
├── frontend/               # React TypeScript frontend
│   ├── src/               # Source code
│   │   ├── components/    # React components
│   │   ├── services/      # API integration
│   │   └── types/         # TypeScript definitions
│   ├── public/            # Static assets
│   ├── Dockerfile         # Frontend container config
│   ├── package.json       # Node.js dependencies
│   └── README.md         # Frontend documentation
├── imgs/                  # Workshop images and assets
├── CLAUDE.md             # AI assistant instructions
└── README.md             # This file
```

## 🔧 Features

### Backend (FastAPI)
- **RESTful API** with full CRUD operations
- **Database Integration** with MariaDB/MySQL support
- **CORS Configuration** for browser compatibility
- **API Documentation** with automatic Swagger generation
- **Docker Support** with multi-stage builds
- **Environment Configuration** via environment variables

### Frontend (React)
- **Modern React 18** with TypeScript
- **Responsive Design** with custom CSS utilities
- **Runtime Configuration** - API URL configurable without rebuilds
- **Docker Containerization** with Nginx serving
- **Error Handling** with user-friendly feedback
- **CRUD Interface** for order management

### Database
- **MariaDB** with persistent storage
- **Structured Schema** with proper indexing
- **Sample Data** for demonstration
- **Docker Ready** with initialization scripts

## 🔄 Development Workflow

### Local Development
Each service has its own development setup documented in its respective README:
- **Backend**: Python virtual environment with FastAPI development server
- **Frontend**: Node.js with hot-reload development server
- **Database**: Docker container or local installation

### Container Development
All services are containerized with Docker for consistent deployment:
- Multi-stage builds for optimized production images
- Environment variable configuration
- Health checks and proper service dependencies

Refer to individual service documentation for specific build and run commands.

## 🎯 Workshop Scenarios

This project demonstrates:

1. **Containerization**: Docker best practices for web applications
2. **Microservices**: Separate frontend/backend services
3. **Database Integration**: Persistent data with MariaDB
4. **Configuration Management**: Environment-based configuration
5. **API Development**: RESTful services with documentation
6. **Modern Frontend**: React with TypeScript and responsive design

## 🔗 OpenShift Resources

- **OpenShift CLI**: https://developers.redhat.com/learning/learn:openshift:download-and-install-red-hat-openshift-cli/resource/resources:download-and-install-oc
- **OpenShift Console**: https://console.ocp4azexp2.cloudsvil.poste.it/

## 🚢 Deployment

The application is designed for easy deployment to:
- **Local Docker** (development)
- **Docker Compose** (testing)
- **Kubernetes** (production)
- **OpenShift** (enterprise)

Each service includes proper health checks, resource limits, and scaling capabilities.

## 🤝 Contributing

This is a workshop project for learning Kubernetes/OpenShift deployment patterns. Feel free to extend and modify for your learning needs.