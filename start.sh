#!/bin/bash

# RAG Chatbot - Start Script for Unix/Linux/macOS
# This script starts both backend and frontend services

set -e

echo "🚀 RAG Chatbot Local Development Startup"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running on Windows
if grep -q Microsoft /proc/version 2>/dev/null; then
    echo -e "${RED}This script is for Unix/Linux/macOS. For Windows, use start.bat${NC}"
    exit 1
fi

# Backend Setup
echo -e "${YELLOW}📦 Setting up Backend...${NC}"
cd Backend

# Create virtual environment if not exists
if [ ! -d "venv" ]; then
    echo "Creating Python virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install dependencies
echo "Installing Python dependencies..."
pip install -q -r requirements.txt

# Initialize database
echo "Initializing database..."
python init_db.py

# Check for .env file
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}⚠️  .env file not found. Copying from .env.example...${NC}"
    cp .env.example .env
    echo -e "${RED}❌ Please edit .env with your API keys and run this script again.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Backend ready!${NC}"

# Start Backend
echo -e "${YELLOW}🎯 Starting Backend (FastAPI)...${NC}"
uvicorn main:app --host 127.0.0.1 --port 8000 --reload &
BACKEND_PID=$!
echo "Backend PID: $BACKEND_PID"

# Give backend time to start
sleep 3

# Frontend Setup
echo ""
echo -e "${YELLOW}📦 Setting up Frontend...${NC}"
cd ../Frontend

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "Installing Node dependencies..."
    npm install
fi

# Check for .env.local file
if [ ! -f ".env.local" ]; then
    echo "Creating .env.local with development defaults..."
    echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local
fi

echo -e "${GREEN}✅ Frontend ready!${NC}"

# Start Frontend
echo -e "${YELLOW}🎯 Starting Frontend (Next.js)...${NC}"
npm run dev &
FRONTEND_PID=$!
echo "Frontend PID: $FRONTEND_PID"

echo ""
echo -e "${GREEN}✅ Both services started successfully!${NC}"
echo ""
echo "📍 Backend running at: http://localhost:8000"
echo "📍 Frontend running at: http://localhost:3000"
echo ""
echo "API Documentation: http://localhost:8000/docs"
echo ""
echo "Press Ctrl+C to stop all services..."

# Wait for interrupt
trap "kill $BACKEND_PID $FRONTEND_PID; echo 'Services stopped.'" EXIT
wait
