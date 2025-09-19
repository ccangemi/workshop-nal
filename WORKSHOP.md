# OpenShift Deployment Workshop

## Workshop Overview

This workshop guides you through deploying a complete 3-tier containerized application to OpenShift. The application consists of:
- **Frontend**: React TypeScript SPA
- **Backend**: Python FastAPI REST API
- **Database**: MariaDB

## Prerequisites

- OpenShift CLI (`oc`) installed
- Access to an OpenShift cluster
- Docker images built or access to container registry

## Workshop Steps

### Step 1: Environment Setup
- [ ] Login to OpenShift cluster
- [ ] Create new project/namespace
- [ ] Verify cluster access

### Step 2: Database Deployment
- [ ] Deploy MariaDB
- [ ] Configure persistent storage
- [ ] Set up database credentials
- [ ] Verify database connectivity

### Step 3: Backend API Deployment
- [ ] Deploy FastAPI application
- [ ] Configure environment variables
- [ ] Set up database connection
- [ ] Create service and expose routes

### Step 4: Frontend Deployment
- [ ] Deploy React application
- [ ] Configure API endpoint
- [ ] Set up Nginx serving
- [ ] Create service and routes

### Step 5: Integration Testing
- [ ] Test complete application flow
- [ ] Verify inter-service communication
- [ ] Check application functionality

### Step 6: Scaling and Management
- [ ] Scale application components
- [ ] Monitor resource usage
- [ ] Configure health checks
- [ ] Set up logging

## Expected Outcomes

By the end of this workshop, participants will have:
- Deployed a complete 3-tier application on OpenShift
- Understood OpenShift deployment patterns
- Configured persistent storage for databases
- Set up service communication and routing
- Implemented monitoring and scaling strategies

## Additional Resources

- [OpenShift Documentation](https://docs.openshift.com/)
- [Container Best Practices](https://developers.redhat.com/blog/2016/02/24/10-things-to-avoid-in-docker-containers)
- [12-Factor App Methodology](https://12factor.net/)