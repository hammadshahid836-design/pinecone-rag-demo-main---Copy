# 🚀 Complete Local Setup Instructions

## Step-by-Step Guide to Get Everything Running Locally

### Prerequisites
- Python 3.11+ ([Download](https://www.python.org/downloads/))
- Node.js 18+ ([Download](https://nodejs.org/))
- Git ([Download](https://git-scm.com/))
- Code editor (VS Code recommended)

### API Keys Needed
- Google Generative AI: https://makersuite.google.com/app/apikey
- Pinecone: https://www.pinecone.io/

---

## ⚡ Fastest Way (1-2 minutes)

### Windows
```batch
start.bat
```
That's it! The script will:
- Create Python virtual environment
- Install all Python packages
- Initialize the database
- Start backend on http://localhost:8000
- Start frontend on http://localhost:3000

### macOS/Linux
```bash
chmod +x start.sh
./start.sh
```

---

## 🔧 Manual Setup (If scripts don't work)

### Part 1: Backend Setup (5 minutes)

**1. Navigate to Backend**
```bash
cd Backend
```

**2. Create Python Virtual Environment**
```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

**3. Install Python Dependencies**
```bash
pip install -r requirements.txt
```

**4. Create .env File**
```bash
# Copy template
cp .env.example .env

# Edit .env in your editor and add:
# GOOGLE_API_KEY=your_actual_key_here
# PINECONE_API_KEY=your_actual_key_here
# PINECONE_ENVIRONMENT=us-east-1-aws
```

**5. Initialize Database**
```bash
python init_db.py
```

Output should show:
```
✅ Database 'users.db' initialized successfully!
📊 Tables created: user_accounts, conversations, knowledge_base_metadata, settings
👥 Sample users inserted: Alice, Bob, Charlie
```

**6. Start Backend Server**
```bash
uvicorn main:app --reload
```

✅ Backend running at: http://localhost:8000

Open in browser: http://localhost:8000/docs to see API documentation

---

### Part 2: Frontend Setup (3 minutes)

**1. Open New Terminal/Command Prompt**

**2. Navigate to Frontend**
```bash
cd Frontend
```

**3. Install Node Dependencies**
```bash
npm install
```

**4. Create Environment File**
```bash
# Windows
echo NEXT_PUBLIC_API_URL=http://localhost:8000 > .env.local

# macOS/Linux
echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local
```

**5. Start Frontend Server**
```bash
npm run dev
```

✅ Frontend running at: http://localhost:3000

---

## 🧪 Testing Everything Works

### Test 1: Backend Health Check
```bash
# In a new terminal
curl http://localhost:8000/health

# Should return:
# {"status":"healthy","database":"connected","embeddings":"initialized","llm":"ready"}
```

### Test 2: Backend API Documentation
Open: http://localhost:8000/docs

You'll see interactive API explorer

### Test 3: Frontend Loads
Open: http://localhost:3000

You should see the chat interface

### Test 4: Send a Message
1. Open http://localhost:3000
2. Type a question: "What is Python?"
3. Click Send
4. Wait for response (may take 3-5 seconds first time)

✅ If you see a response, everything is working!

---

## 🐳 Docker Setup (Alternative)

### Install Docker
- **Windows/Mac**: Download [Docker Desktop](https://www.docker.com/products/docker-desktop)
- **Linux**: `sudo apt install docker.io docker-compose`

### Start with Docker
```bash
# Navigate to project root
cd pinecone-rag-demo

# Create .env file with API keys
cp Backend/.env.example Backend/.env
# Edit Backend/.env

# Start all services
docker-compose up -d

# Wait 30 seconds for services to start
sleep 30

# Check status
docker-compose ps
```

Access:
- Frontend: http://localhost:3000
- Backend: http://localhost:8000
- API Docs: http://localhost:8000/docs

Stop:
```bash
docker-compose down
```

---

## 🆘 Troubleshooting

### "Python command not found" (macOS/Linux)
Use `python3` instead of `python`:
```bash
python3 -m venv venv
source venv/bin/activate
```

### "pip: command not found"
```bash
# Download get-pip.py
python get-pip.py

# Or update pip
python -m pip install --upgrade pip
```

### "Cannot find module X"
Re-install dependencies:
```bash
pip install -r requirements.txt
```

### "Port 8000 already in use"
```bash
# Find and kill process using port 8000
# Windows
netstat -ano | findstr :8000

# macOS/Linux
lsof -i :8000
kill -9 <PID>
```

### "GOOGLE_API_KEY not set"
1. Get key from: https://makersuite.google.com/app/apikey
2. Add to `.env` file: `GOOGLE_API_KEY=your_key_here`
3. Restart backend: Stop and run `uvicorn main:app --reload`

### ".env.local not found" (Frontend)
Create it:
```bash
echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > Frontend/.env.local
```

### "Cannot connect to backend" (Frontend)
1. Check backend is running: `curl http://localhost:8000/health`
2. Check frontend .env.local has correct URL
3. Check CORS in backend .env: `ALLOWED_ORIGINS=["http://localhost:3000"]`

### Database error
```bash
# Delete and recreate database
rm Backend/users.db
python Backend/init_db.py
```

---

## 📁 What Gets Created

After setup, you'll have:
```
Backend/
├── venv/                    # Virtual environment
├── __pycache__/            # Python cache
├── users.db                # SQLite database
└── .env                    # Environment variables

Frontend/
├── node_modules/           # Node packages
├── .next/                  # Next.js build
└── .env.local             # Environment variables
```

---

## 🧠 How to Use the Application

### Chat Features
1. **Type a question** in the chat box
2. **Instant response** from the AI chatbot
3. **View history** of previous conversations
4. **Add knowledge** by uploading documents (admin feature)

### Example Questions
- "What is artificial intelligence?"
- "Tell me about machine learning"
- "How does RAG work?"
- "What are the benefits of vector databases?"

### API Endpoints to Explore
Via Swagger UI: http://localhost:8000/docs

- `GET /` - Server status
- `POST /chat` - Send message
- `GET /user/{id}` - User profile
- `GET /user/{id}/conversations` - Chat history
- `POST /knowledge/add` - Add document

---

## 🎯 Next Steps

1. ✅ **Local Testing** - Verify everything works locally
2. ✅ **Customize** - Modify prompts, add custom data
3. ✅ **Deploy** - Follow `CUSTOM_DEPLOYMENT_GUIDE.md` for cloud

---

## 📞 Quick Help

| Problem | Solution |
|---------|----------|
| 🔴 Backend won't start | Check Python 3.11+, verify .env |
| 🔴 Frontend can't load | Check Node.js installed |
| 🔴 Can't send messages | Check both servers running |
| 🔴 API errors | Check `http://localhost:8000/docs` |
| 🔴 Database errors | Run `python Backend/init_db.py` |

---

## ✅ Success Checklist

- [ ] Python 3.11+ installed
- [ ] Node.js 18+ installed
- [ ] Backend running on port 8000
- [ ] Frontend running on port 3000
- [ ] Can access http://localhost:3000
- [ ] Can send messages and get responses
- [ ] API docs visible at /docs
- [ ] No errors in terminal

---

**You're all set! 🎉**

Once everything works locally, you can deploy to:
- Backend → Render
- Frontend → Vercel

See `CUSTOM_DEPLOYMENT_GUIDE.md` for cloud deployment.

Questions? Check:
1. `QUICK_START.md` - Quick overview
2. `CUSTOM_DEPLOYMENT_GUIDE.md` - Detailed setup
3. `SETUP_VERIFICATION.md` - Verification checklist
