# RAG Chatbot Deployment Guide

## Overview
This guide provides complete instructions for deploying the RAG-based Chatbot application with:
- **Backend**: FastAPI + LangGraph + Pinecone + SQLite (on Render)
- **Frontend**: Next.js + React (on Vercel)

---

## Prerequisites

### Required Accounts & APIs
1. **Google Generative AI** (Gemini 2.0 Flash)
   - Get API key from: https://makersuite.google.com/app/apikey
   - Free tier available

2. **Pinecone Vector Database**
   - Sign up: https://www.pinecone.io/
   - Create index named: `rag-chatbot`
   - Copy API Key and Environment

3. **Render** (Backend Hosting)
   - Sign up: https://render.com/
   - Free plan available for testing

4. **Vercel** (Frontend Hosting)
   - Sign up: https://vercel.com/
   - Free tier with Next.js optimization

---

## Backend Deployment (Render)

### Step 1: Prepare Backend

```bash
# 1. Navigate to Backend directory
cd Backend

# 2. Initialize database
python init_db.py

# 3. Install dependencies locally (for testing)
pip install -r requirements.txt

# 4. Create .env file with your credentials
cp .env.example .env
# Edit .env and add:
# - GOOGLE_API_KEY
# - PINECONE_API_KEY
# - PINECONE_ENVIRONMENT
```

### Step 2: Push to GitHub

```bash
# Initialize git repo (if not already done)
git init
git add .
git commit -m "Initial RAG chatbot implementation"

# Create new repository on GitHub and push
git remote add origin https://github.com/YOUR_USERNAME/pinecone-rag-demo.git
git branch -M main
git push -u origin main
```

### Step 3: Deploy on Render

1. Go to https://dashboard.render.com/
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository
4. Configure deployment:
   - **Name**: `rag-chatbot-backend`
   - **Environment**: `Python 3.11`
   - **Build Command**: 
     ```
     pip install -r Backend/requirements.txt
     ```
   - **Start Command**: 
     ```
     cd Backend && uvicorn main:app --host 0.0.0.0 --port $PORT
     ```
   - **Plan**: Standard ($12/month) or Starter (free, limited)

5. Add Environment Variables:
   - `GOOGLE_API_KEY`: Your Google API key
   - `PINECONE_API_KEY`: Your Pinecone API key
   - `PINECONE_INDEX_NAME`: rag-chatbot
   - `PINECONE_ENVIRONMENT`: your-environment
   - `ENVIRONMENT`: production
   - `DEBUG`: False
   - `ALLOWED_ORIGINS`: ["https://your-frontend-domain.vercel.app"]

6. Click **"Create Web Service"**
7. Wait for deployment (5-10 minutes)
8. Copy your Render URL: `https://rag-chatbot-backend.onrender.com`

---

## Frontend Deployment (Vercel)

### Step 1: Prepare Frontend

```bash
# Navigate to Frontend directory
cd Frontend

# Install dependencies
npm install

# Create .env.local for development
echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local

# Test locally
npm run dev
# Visit http://localhost:3000
```

### Step 2: Update API Configuration

Edit or create `Frontend/.env.local`:
```
NEXT_PUBLIC_API_URL=https://rag-chatbot-backend.onrender.com
```

### Step 3: Deploy on Vercel

1. Go to https://vercel.com/dashboard
2. Click **"Add New"** → **"Project"**
3. Import your GitHub repository
4. Configure project:
   - **Framework Preset**: Next.js
   - **Root Directory**: `Frontend`
   - Keep build settings as default

5. Add Environment Variable:
   - **NEXT_PUBLIC_API_URL**: `https://rag-chatbot-backend.onrender.com`

6. Click **"Deploy"**
7. Wait for deployment (3-5 minutes)
8. Your app will be at: `https://your-project-name.vercel.app`

---

## Local Development Setup

### Start Backend Locally

```bash
cd Backend

# 1. Create virtual environment
python -m venv venv

# Windows
venv\Scripts\activate

# macOS/Linux
source venv/bin/activate

# 2. Install dependencies
pip install -r requirements.txt

# 3. Initialize database
python init_db.py

# 4. Create .env file
cp .env.example .env
# Edit .env with your API keys

# 5. Start server
uvicorn main:app --reload --host 127.0.0.1 --port 8000
# Server runs at http://localhost:8000
```

### Start Frontend Locally

```bash
cd Frontend

# 1. Install dependencies
npm install

# 2. Create environment file
echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local

# 3. Start development server
npm run dev
# App runs at http://localhost:3000
```

---

## API Endpoints

### Health Check
```bash
GET /
GET /health
```

### Chat
```bash
POST /chat
Content-Type: application/json

{
  "query": "What is the capital of France?",
  "user_id": 1
}
```

### Users
```bash
GET /user/{user_id}
POST /user
GET /user/{user_id}/conversations

POST /user
{
  "name": "John Doe",
  "email": "john@example.com",
  "plan_type": "Premium"
}
```

### Knowledge Base
```bash
POST /knowledge/add
{
  "document_id": "doc1",
  "title": "Document Title",
  "source": "source_url",
  "category": "category_name",
  "content": "Document content..."
}

GET /knowledge/metadata?category=category_name
```

---

## Troubleshooting

### Backend Won't Start on Render
- Check all **Environment Variables** are set correctly
- Check **Build Logs** in Render dashboard
- Verify database initialization: ensure `init_db.py` runs
- Try redeploying: Settings → Manual Deploy → Deploy Latest

### Frontend Can't Connect to Backend
- Verify `NEXT_PUBLIC_API_URL` is set correctly in Vercel
- Check CORS settings in Backend: `ALLOWED_ORIGINS` must include frontend URL
- Check browser console for CORS errors
- Verify backend is running: visit `https://rag-chatbot-backend.onrender.com/health`

### Pinecone Connection Error
- Verify `PINECONE_API_KEY` is correct
- Verify `PINECONE_INDEX_NAME` matches created index
- Verify `PINECONE_ENVIRONMENT` is correct
- Check Pinecone dashboard for index status

### Database Errors
- Delete `users.db` and run `python init_db.py` again
- Check file permissions
- Verify SQLite is installed: `python -c "import sqlite3; print(sqlite3.version)"`

---

## Environment Variables Reference

### Backend (.env)
```
# Google AI
GOOGLE_API_KEY=your_key_here

# Pinecone
PINECONE_API_KEY=your_key_here
PINECONE_INDEX_NAME=rag-chatbot
PINECONE_ENVIRONMENT=us-east-1-aws

# Application
ENVIRONMENT=production
DEBUG=False
LOG_LEVEL=INFO
API_HOST=0.0.0.0
API_PORT=8000

# Frontend URL
FRONTEND_URL=https://your-frontend.vercel.app

# CORS
ALLOWED_ORIGINS=["https://your-frontend.vercel.app"]

# LLM
LLM_MODEL=gemini-2.0-flash
TEMPERATURE=0.3
MAX_TOKENS=2048
```

### Frontend (.env.local / Vercel)
```
NEXT_PUBLIC_API_URL=https://rag-chatbot-backend.onrender.com
```

---

## Production Checklist

- [ ] Google Generative AI API key obtained and tested
- [ ] Pinecone index created and API key obtained
- [ ] GitHub repository set up and pushed
- [ ] Backend deployed on Render with all env vars
- [ ] Backend health check responding (/health endpoint)
- [ ] Frontend deployed on Vercel
- [ ] Frontend connects to backend successfully
- [ ] Chat functionality works end-to-end
- [ ] Database is persisting data correctly
- [ ] CORS properly configured
- [ ] All error handling working
- [ ] Performance acceptable (load times < 3s)

---

## Performance Optimization

### Backend
- Use Pinecone's metadata filtering for faster searches
- Implement caching for frequently accessed documents
- Consider using connection pooling for SQLite
- Monitor token usage for cost optimization

### Frontend  
- Enable Next.js image optimization
- Implement debouncing for chat input
- Use React.memo for message components
- Lazy load chat message components

---

## Support & Resources

- **FastAPI Docs**: https://fastapi.tiangolo.com/
- **LangGraph**: https://github.com/langchain-ai/langgraph
- **Pinecone**: https://docs.pinecone.io/
- **Render Docs**: https://render.com/docs
- **Vercel Docs**: https://vercel.com/docs
- **Next.js Docs**: https://nextjs.org/docs

---

Generated: 2026-02-12
Last Updated: 2026-02-12
