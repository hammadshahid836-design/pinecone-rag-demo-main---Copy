# 🚀 QUICK START - RUN YOUR RAG CHATBOT NOW!

## ⚡ 5-MINUTE SETUP

### Step 1: Get API Keys (2 minutes)

**Google Gemini API:**
1. Go to https://ai.google.dev
2. Click "Get API Key"
3. Create new project
4. Copy your API key

**Pinecone Vector DB:**
1. Sign up at https://pinecone.io
2. Create free index (name: `rag-chatbot`)
3. Copy your API key

### Step 2: Setup Backend (2 minutes)

```bash
# Open PowerShell/Terminal in project root
cd Backend

# Create virtual environment
python -m venv venv

# Activate (Windows)
venv\Scripts\activate
# Or Mac/Linux:
# source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create .env file from template
cp .env.example .env
```

**Edit `Backend/.env`:**
```env
GOOGLE_API_KEY=sk-... (paste your key)
PINECONE_API_KEY=... (paste your key)
```

**Start backend:**
```bash
python init_db.py    # Initialize database
python main.py       # Start server
```

You should see:
```
🚀 Starting RAG Chatbot Backend...
✅ Backend initialized successfully!
Uvicorn running on http://127.0.0.1:8000
```

### Step 3: Setup Frontend (1 minute)

**Open NEW terminal/PowerShell:**
```bash
cd Frontend
npm install
npm run dev
```

You should see:
```
▲ Next.js 16.1.6
- Local: http://localhost:3000
```

### Step 4: Test! 

Open http://localhost:3000 in your browser and start chatting! 🎉

---

## 🧪 QUICK TEST

### Test Chat via Browser:
1. Go to http://localhost:3000
2. Type: "Tell me about Alice Smith"
3. Get instant AI response!

### Test Chat via curl:
```bash
curl -X POST http://127.0.0.1:8000/chat \
  -H "Content-Type: application/json" \
  -d '{"query":"Hello!","user_id":1}'
```

### Test Health:
```bash
curl http://127.0.0.1:8000/health
```

---

## 📱 API DOCUMENTATION

**Interactive API Docs:**
- http://127.0.0.1:8000/docs (Swagger UI)
- http://127.0.0.1:8000/redoc (ReDoc)

**Key Endpoints:**
```
POST   /chat                     → Chat with RAG bot
GET    /user/{id}               → Get user profile
GET    /user/{id}/conversations → Get chat history
POST   /knowledge/add           → Add documents
GET    /health                  → Health check
```

---

## 🌐 DEPLOY TO PRODUCTION

### Deploy Backend to Render:

1. Push code to GitHub
2. Go to https://render.com
3. New Web Service
4. Connect your GitHub repo
5. Settings:
   - Name: `rag-chatbot-backend`
   - Build: `pip install -r Backend/requirements.txt`
   - Start: `cd Backend && uvicorn main:app --host 0.0.0.0 --port $PORT`
6. Add environment variables from `.env`
7. Deploy!

Get URL: `https://rag-chatbot-backend-xxxxx.onrender.com`

### Deploy Frontend to Vercel:

1. Go to https://vercel.com
2. Import project from GitHub
3. Framework: Next.js
4. Environment: `NEXT_PUBLIC_API_URL=https://your-backend-url.onrender.com`
5. Deploy!

---

## ✅ WHAT'S READY

- ✅ FastAPI backend with 7+ endpoints
- ✅ LangGraph RAG with dual databases
- ✅ Next.js frontend
- ✅ API client & hooks
- ✅ SQLite with sample users
- ✅ Pinecone integration
- ✅ Google Gemini LLM
- ✅ Full error handling
- ✅ Production configs

---

## 🎯 YOUR RAG CHATBOT HAS:

### Dual Database Access:
- **Pinecone**: Semantic search on public knowledge
- **SQLite**: User-specific data & conversation history

### Example Flow:
1. User asks: "What's my account balance?"
2. LangGraph searches both databases
3. Finds: User profile in SQLite
4. Returns: "Your balance is $150.00"

---

## 🆘 TROUBLESHOOTING

| Problem | Solution |
|---------|----------|
| `ModuleNotFoundError` | Run: `pip install -r requirements.txt` |
| `CORS Error` | Check `ALLOWED_ORIGINS` in `.env` |
| `Port 8000 in use` | Change `API_PORT` in `.env` |
| `No API key` | Add keys to `Backend/.env` |
| `Connection error` | Check backend is running on 8000 |

---

## 📚 DOCUMENTATION

- **Complete Guide**: See `README.md`
- **Deployment Guide**: See `DEPLOYMENT_COMPLETE.md`
- **Implementation Checklist**: See `IMPLEMENTATION_COMPLETE.md`

---

## 🎓 LEARN MORE

- LangChain: https://python.langchain.com/
- LangGraph: https://langchain-ai.github.io/langgraph/
- Pinecone: https://docs.pinecone.io/
- FastAPI: https://fastapi.tiangolo.com/
- Next.js: https://nextjs.org/

---

## 📊 ARCHITECTURE

```
User → Frontend (Next.js)
         ↓
      API Service
         ↓
    FastAPI Backend
         ├→ LangGraph Agent
         │  ├→ Pinecone (Vector DB)
         │  └→ SQLite (Local DB)
         └→ Google Gemini LLM
         ↓
    AI Response ← Backend
         ↓
User ← Frontend
```

---

## 🚀 READY?

**Everything is set up and ready to go!**

```bash
# Backend
cd Backend && python main.py

# Frontend (new terminal)
cd Frontend && npm run dev

# Open http://localhost:3000
```

**That's it! You're running your RAG chatbot! 🎉**

---

## 💡 NEXT STEPS

1. ✅ Run locally (you're here!)
2. ✅ Add your documents to knowledge base
3. ✅ Test chat functionality
4. ✅ Deploy to Render (backend)
5. ✅ Deploy to Vercel (frontend)
6. ✅ Share with users!

---

**Happy coding! The future of RAG is here. 🤖✨**
