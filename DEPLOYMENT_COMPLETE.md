# 🚀 RAG CHATBOT - COMPLETE SETUP & DEPLOYMENT GUIDE

## ✅ WHAT'S IMPLEMENTED

### Backend Features:
- ✅ FastAPI REST API with all endpoints
- ✅ LangGraph RAG with dual database support
- ✅ Pinecone vector database integration
- ✅ SQLite local database (users, conversations, knowledge base)
- ✅ Google Gemini 2.0 Flash LLM
- ✅ Conversation history storage
- ✅ CORS configured
- ✅ Health checks & error handling
- ✅ Production-ready logging

### Deployment:
- ✅ Render backend deployment config (render.yaml)
- ✅ Vercel frontend deployment config (vercel.json)
- ✅ Environment configuration (.env.example)
- ✅ Requirements.txt with all dependencies

---

## 📋 PRE-REQUISITES

1. **Python 3.11+** - [Download](https://www.python.org/downloads/)
2. **Node.js 18+** - [Download](https://nodejs.org/)
3. **Git** - [Download](https://git-scm.com/)

### API Keys Required:
1. **Google API Key** (for Gemini LLM)
   - Get from: https://ai.google.dev
   - Click "Get API Key"

2. **Pinecone API Key** (for vector database)
   - Sign up: https://pinecone.io
   - Create free index
   - Copy API key

---

## 🔧 LOCAL SETUP (Development)

### Step 1: Setup Backend

```bash
# Navigate to Backend directory
cd Backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On Mac/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create .env file
cp .env.example .env
```

### Step 2: Configure .env File

Edit `Backend/.env` and add your API keys:

```env
# Google API Configuration
GOOGLE_API_KEY=sk-... (get from https://ai.google.dev)

# Pinecone Configuration
PINECONE_API_KEY=... (get from https://pinecone.io)
PINECONE_INDEX_NAME=rag-chatbot

# Local development settings
API_HOST=127.0.0.1
API_PORT=8000
ENVIRONMENT=development
DEBUG=True
ALLOWED_ORIGINS=["http://localhost:3000"]
```

### Step 3: Initialize Database

```bash
# Initialize SQLite database
python init_db.py

# You should see:
# ✅ Database initialized with tables
# Sample User 1: Alice Smith (alice@example.com) - Plan: Premium
```

### Step 4: Run Backend

```bash
# Start FastAPI server
python main.py

# You should see:
# 🚀 Starting RAG Chatbot Backend...
# ✅ Backend initialized successfully!
# Uvicorn running on http://127.0.0.1:8000
```

Visit: http://127.0.0.1:8000/docs for API documentation

### Step 5: Setup Frontend

```bash
# Open new terminal, navigate to Frontend
cd Frontend

# Install dependencies
npm install

# Set environment variable
# Create .env.local file
echo "NEXT_PUBLIC_API_URL=http://127.0.0.1:8000" > .env.local

# Start development server
npm run dev

# Visit: http://localhost:3000
```

---

## 🤖 TEST THE CHATBOT

### Using Web UI:
1. Open http://localhost:3000
2. Type a question
3. Wait for AI response from Pinecone + local database

### Using API (curl):

```bash
# Health check
curl http://127.0.0.1:8000/health

# Chat endpoint
curl -X POST http://127.0.0.1:8000/chat \
  -H "Content-Type: application/json" \
  -d '{"query": "Who is Alice Smith?", "user_id": 1}'

# Get user profile
curl http://127.0.0.1:8000/user/1

# Get conversations
curl http://127.0.0.1:8000/user/1/conversations
```

---

## 🌐 DEPLOY TO PRODUCTION

### A. Deploy Backend to Render

1. Push code to GitHub
2. Go to https://render.com
3. Click "New Web Service"
4. Connect your GitHub repo
5. Fill in:
   - **Name:** `rag-chatbot-backend`
   - **Runtime:** Python 3.11
   - **Build Command:** `pip install -r Backend/requirements.txt`
   - **Start Command:** `cd Backend && uvicorn main:app --host 0.0.0.0 --port $PORT`
6. Add environment variables:
   - `GOOGLE_API_KEY`: Your API key
   - `PINECONE_API_KEY`: Your API key
   - `PINECONE_INDEX_NAME`: `rag-chatbot`
   - `ENVIRONMENT`: `production`
   - `ALLOWED_ORIGINS`: `["https://your-frontend.vercel.app"]`
7. Click "Create Web Service"

Get your Render URL: `https://rag-chatbot-backend.onrender.com`

### B. Deploy Frontend to Vercel

1. Go to https://vercel.com
2. Click "Add New Project"
3. Import your GitHub repo
4. Configure:
   - **Framework:** Next.js
   - **Build Command:** `npm run build`
5. Add Environment Variable:
   - **Name:** `NEXT_PUBLIC_API_URL`
   - **Value:** `https://rag-chatbot-backend.onrender.com`
6. Click "Deploy"

Get your Vercel URL: `https://your-project.vercel.app`

---

## 📝 API ENDPOINTS

### Chat
- **POST** `/chat`
  - Request: `{"query": "Your question", "user_id": 1}`
  - Response: `{"answer": "AI response", "user_id": 1, "timestamp": "..."}`

### Users
- **GET** `/user/{user_id}` - Get user profile
- **POST** `/user` - Create new user
- **GET** `/user/{user_id}/conversations` - Get chat history

### Knowledge Base
- **POST** `/knowledge/add` - Add document
- **GET** `/knowledge/metadata` - Get all documents

### Health
- **GET** `/health` - Health check
- **GET** `/` - Status check

---

## 🐛 TROUBLESHOOTING

**Q: "ModuleNotFoundError: No module named 'langchain'"**
- Solution: `pip install -r requirements.txt`

**Q: "Invalid API key for Pinecone"**
- Solution: Check PINECONE_API_KEY in .env file

**Q: "CORS error from frontend"**
- Solution: Update ALLOWED_ORIGINS in .env with your frontend URL

**Q: "Database not found"**
- Solution: Run `python init_db.py` in Backend directory

**Q: "Connection refused on port 8000"**
- Solution: Backend not running. Run `python main.py`

---

## 📦 FILE STRUCTURE

```
├── Backend/
│   ├── main.py                 # FastAPI server
│   ├── rag_agent.py           # LangGraph RAG implementation
│   ├── database_service.py    # SQLite database
│   ├── init_db.py             # Database initialization
│   ├── requirements.txt        # Python dependencies
│   ├── render.yaml             # Render deployment config
│   ├── .env.example            # Environment template
│   └── users.db               # SQLite database (auto-created)
├── Frontend/
│   ├── package.json            # Node dependencies
│   ├── next.config.js         # Next.js config
│   ├── vercel.json            # Vercel deployment config
│   ├── tsconfig.json          # TypeScript config
│   └── src/
│       ├── app/               # Pages & layout
│       ├── components/        # React components
│       ├── services/          # API services
│       └── utils/             # Utilities
```

---

## ✨ FEATURES POST-DEPLOYMENT

### Pinecone Vector Database
- Stores document embeddings
- Fast semantic search
- Scalable for millions of documents

### SQLite Local Database
- User profiles & authentication
- Conversation history
- Knowledge base metadata

### Dual-Database RAG
- Searches both Pinecone (general knowledge)
- AND local database (user-specific data)
- Combines results for comprehensive answers

### LangGraph Workflow
- State management
- Tool calling (Pinecone, local DB, user profile)
- Error recovery
- Conversation persistence

---

## 🎯 NEXT STEPS

1. **Test Locally** - Follow "TEST THE CHATBOT" section
2. **Deploy Backend** - Push to Render
3. **Deploy Frontend** - Push to Vercel
4. **Add Knowledge** - Use `/knowledge/add` endpoint
5. **Monitor** - Check Render & Vercel dashboards

---

## 📞 SUPPORT

For issues:
1. Check logs: `Backend/` and `Frontend/`
2. Verify API keys in `.env`
3. Test endpoints with curl
4. Check Render/Vercel dashboards for deployment errors

---

**🚀 You're all set! Your RAG chatbot is ready to deploy!**
