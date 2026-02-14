# RAG Chatbot - Quick Start Guide

## 🚀 5-Minute Quick Start

### Option 1: Docker (Recommended - Fastest)

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/pinecone-rag-demo.git
cd pinecone-rag-demo

# 2. Create .env file with your API keys
cp Backend/.env.example Backend/.env
# Edit Backend/.env with:
#   GOOGLE_API_KEY=your_key
#   PINECONE_API_KEY=your_key
#   PINECONE_ENVIRONMENT=us-east-1-aws

# 3. Start with Docker Compose
docker-compose up -d

# Wait 30 seconds for services to start

# 4. Access the app
# Frontend: http://localhost:3000
# Backend: http://localhost:8000
# API Docs: http://localhost:8000/docs
```

### Option 2: Local Development (Manual)

**Windows:**
```batch
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/pinecone-rag-demo.git
cd pinecone-rag-demo

# 2. Run the startup script
start.bat

# 3. Follow on-screen instructions
```

**macOS/Linux:**
```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/pinecone-rag-demo.git
cd pinecone-rag-demo

# 2. Make startup script executable
chmod +x start.sh

# 3. Run the startup script
./start.sh

# 4. Open browser to http://localhost:3000
```

**Manual Setup:**
```bash
# Backend
cd Backend
python -m venv venv
source venv/bin/activate  # venv\Scripts\activate on Windows
pip install -r requirements.txt
python init_db.py
uvicorn main:app --reload

# In another terminal - Frontend
cd Frontend
npm install
echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local
npm run dev
```

---

## 📋 Pre-Deployment Checklist

- [ ] Have Google Generative AI API key
- [ ] Have Pinecone API key and index created
- [ ] Have GitHub account
- [ ] Have Render account (for backend)
- [ ] Have Vercel account (for frontend)

---

## 🌐 Deploy to Cloud (10 minutes)

### Backend on Render

1. Push code to GitHub
2. Go to https://render.com → New Web Service
3. Connect GitHub repo
4. Set build command: `pip install -r Backend/requirements.txt`
5. Set start command: `cd Backend && uvicorn main:app --host 0.0.0.0 --port $PORT`
6. Add environment variables (Google API Key, Pinecone API Key, etc.)
7. Deploy!
8. Copy your backend URL

### Frontend on Vercel

1. Go to https://vercel.com → New Project
2. Import your GitHub repo
3. Root Directory: `Frontend`
4. Add env var: `NEXT_PUBLIC_API_URL=https://your-render-url.onrender.com`
5. Deploy!
6. Get your frontend URL

---

## 🧪 Test the Application

### Test Backend
```bash
# Health check
curl http://localhost:8000/health

# API Documentation
# Open: http://localhost:8000/docs

# Test chat endpoint
curl -X POST "http://localhost:8000/chat" \
  -H "Content-Type: application/json" \
  -d '{"query": "What is Python?", "user_id": 1}'
```

### Test Frontend
```bash
# Open http://localhost:3000 in your browser
# Test chat functionality
# Ask a question and verify response
```

---

## 🛠️ Troubleshooting

### "Cannot connect to backend"
- Check backend is running: `curl http://localhost:8000/health`
- Check frontend .env.local has correct API URL
- Check CORS settings if deployed

### "Pinecone connection error"
- Verify API key is correct
- Verify index name matches
- Check Pinecone dashboard

### "Database error"
- Delete `Backend/users.db`
- Run `python Backend/init_db.py`

### "Google API error"
- Verify API key is valid
- Check API is enabled in Google Cloud Console

---

## 📚 Key Files

- **Backend**: `Backend/main.py` - FastAPI server
- **RAG Agent**: `Backend/rag_agent.py` - LangGraph implementation
- **Database**: `Backend/database_service.py` - SQLite operations
- **Frontend**: `Frontend/src/app/page.tsx` - Main React component
- **Config**: `.env.example` - Environment variables template

---

## 🔗 Important Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/health` | GET | Health check |
| `/chat` | POST | Send message to chatbot |
| `/user/{id}` | GET | Get user info |
| `/user` | POST | Create new user |
| `/user/{id}/conversations` | GET | Get chat history |
| `/knowledge/add` | POST | Add document to knowledge base |
| `/docs` | GET | FastAPI documentation |

---

## 📚 Resources

- **Full Guide**: See `CUSTOM_DEPLOYMENT_GUIDE.md`
- **FastAPI Docs**: https://fastapi.tiangolo.com/
- **LangGraph**: https://github.com/langchain-ai/langgraph
- **Next.js Docs**: https://nextjs.org/docs
- **Render Docs**: https://render.com/docs
- **Vercel Docs**: https://vercel.com/docs

---

## ❓ Need Help?

1. Check the full deployment guide: `CUSTOM_DEPLOYMENT_GUIDE.md`
2. Review backend logs in `Backend/` terminal
3. Check browser console (F12) for frontend errors
4. Check Render/Vercel dashboards if deployed

---

**Ready to start? Run `start.bat` (Windows) or `./start.sh` (Mac/Linux)!**
