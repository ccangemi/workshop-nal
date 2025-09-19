# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Kubernetes workshop repository focused on Red Hat OpenShift with a Python FastAPI backend application.

## Project Structure

- `backend/` - Python FastAPI backend application with modular structure
  - `main.py` - Application entry point
  - `app/` - Main application package with MVC architecture
    - `config/` - Configuration modules
    - `models/` - Data models
    - `repositories/` - Data access layer
    - `routes/` - API route handlers
  - `Dockerfile` - Container configuration for deployment
  - `requirements.txt` - Python dependencies
  - `.env.example` - Environment variables template
  - `README.md` - Backend-specific documentation
- `imgs/` - Directory for images and workshop assets
- `README.md` - Workshop resources and OpenShift console links

## Key Resources

The workshop references these important resources:
- Red Hat OpenShift CLI download: https://developers.redhat.com/learning/learn:openshift:download-and-install-red-hat-openshift-cli/resource/resources:download-and-install-oc
- OpenShift Console: https://console.ocp4azexp2.cloudsvil.poste.it/

## Development Notes

This is a workshop/learning repository for hands-on Kubernetes/OpenShift exercises. The backend contains a Python FastAPI application designed for containerization and deployment demonstrations.

### Backend Development
- Python FastAPI framework with structured architecture
- Dockerized for container deployment
- Environment configuration through `.env` files
- Modular design following MVC patterns

### Workshop Focus
When working with this repository, consider that it's intended for educational purposes related to:
- Kubernetes and OpenShift deployment
- Container orchestration
- FastAPI application development
- Cloud-native application patterns