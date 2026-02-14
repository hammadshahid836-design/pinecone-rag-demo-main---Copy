# 🏗️ RAG Chatbot - Complete System Architecture

---

## 📊 High-Level System Diagram

```
                        ┌─────────────────────────────────┐
                        │      User Browser               │
                        │    http://localhost:3000        │
                        └────────────────┬────────────────┘
                                         │
                                    HTTPS ↓
                        ┌─────────────────────────────────┐
                        │     Next.js Frontend            │
                        │  (React 19 + TypeScript)        │
                        │  - Chat Interface               │
                        │  - Message Display              │
                        │  - API Integration              │
                        └────────────────┬────────────────┘
                                         │
                                    HTTP/JSON ↓
                        ╔═════════════════════════════════╗
                        ║  FastAPI Backend Server         ║
                        ║  http://localhost:8000          ║
                        ║  (LangChain + LangGraph)        ║
                        ║  - Chat Endpoint                ║
                        ║  - User Management              ║
                        ║  - Knowledge Base API           ║
                        ╚═════════════┬══════════════════╝
                                      │
                    ┌─────────────────┼─────────────────┐
                    │                 │                 │
            Vector Search↓    Local Search↓      Save↓
        ┌──────────────────┐  ┌──────────────┐  ┌──────────────┐
        │ Pinecone Vector  │  │  SQLite DB   │  │  Gemini LLM  │
        │  Database        │  │ (users.db)   │  │(Google AI)   │
        │ - Documents      │  │ - Users      │  │ - Generate   │
        │ - Embeddings     │  │ - Chats      │  │   Responses  │
        │ - Searches       │  │ - Metadata   │  │              │
        └──────────────────┘  └──────────────┘  └──────────────┘
```

---

## 🔋 System Components

### 1. Frontend Layer (Vercel)
```
Frontend (Next.js)
├── User Interface
│   ├── Chat Container
│   │   ├── Input Box
│   │   ├── Send Button
│   │   └── Message History
│   └── User Dashboard
│       ├── Profile
│       └── Settings
├── API Services
│   ├── chatService.ts
│   ├── userService.ts
│   └── knowledgeService.ts
└── Styling
    ├── Tailwind CSS
    └── Custom Components
```

### 2. Backend API Layer (Render)
```
FastAPI Server
├── Main Entry Point (main.py)
│   ├── Health Endpoints
│   ├── Chat Endpoint
│   ├── User Endpoints
│   ├── Knowledge Endpoints
│   └── Error Handlers
├── RAG Agent (rag_agent.py)
│   ├── LangGraph Workflow
│   ├── Tool Management
│   ├── Message Processing
│   └── State Management
└── Database Layer (database_service.py)
    ├── User Operations
    ├── Conversation Tracking
    ├── Knowledge Management
    └── Settings Management
```

### 3. Data Storage Layer
```
Data Storage
├── Vector Database (Pinecone)
│   ├── Document Embeddings
│   ├── Semantic Search
│   └── Knowledge Base
└── Relational Database (SQLite)
    ├── Users Table
    ├── Conversations Table
    ├── Knowledge Metadata Table
    └── Settings Table
```

### 4. AI/LLM Layer
```
Generative AI (Google Gemini 2.0)
├── Text Generation
├── Understanding Context
├── Response Formation
└── Token Management
```

---

## 📡 Request Flow Diagram

```
USER INPUT
    │
    ▼
┌─────────────────────────────────┐
│  Frontend (React Component)      │
│  - User types message            │
│  - Format as JSON                │
└──────────────┬──────────────────┘
               │
               │ POST /chat
               ▼
┌─────────────────────────────────┐
│  FastAPI Server                  │
│  - Receive request               │
│  - Validate input                │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│  LangGraph RAG Agent             │
│  - Create message                │
│  - Initialize state              │
└──────────────┬──────────────────┘
               │
        ┌──────┴──────┐
        │             │
        ▼             ▼
    ┌────────┐  ┌──────────┐
    │Pinecone│  │ SQLite   │
    │ Search │  │ Search   │
    └───┬────┘  └────┬─────┘
        │            │
        │ Results    │ Results
        └──────┬─────┘
               │
               ▼
        ┌────────────────┐
        │ Combine Results│
        └────────┬───────┘
                 │
                 ▼
        ┌──────────────────────┐
        │ Google Gemini LLM    │
        │ - Process context    │
        │ - Generate response  │
        └────────┬─────────────┘
                 │
                 ▼
        ┌──────────────────────┐
        │ Format Response      │
        │ Save to DB           │
        └────────┬─────────────┘
                 │
                 ▼ Response (JSON)
        ┌──────────────────────┐
        │ Frontend (React)     │
        │ - Display message    │
        │ - Show in chat       │
        └──────────────────────┘
                 │
                 ▼
            USER SEES
          AI RESPONSE
```

---

## 🔐 Data Flow Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   End-to-End Encryption                 │
└─────────┬───────────────────────────────────────┬───────┘
          │                                       │
          ▼                                       ▼
┌──────────────────────┐              ┌────────────────────┐
│  Client (Browser)    │              │  Backend Server    │
│  - No API keys       │              │  - Secret Keys     │
│  - Public URL only   │              │  - Database access │
│  - Session storage   │              │  - LLM credentials │
└──────────────────────┘              └────────────────────┘
          │                                       │
          └───────────────────┬───────────────────┘
                              │
                        Secure HTTPS
                              │
                    No credentials sent
```

---

## 🎯 Database Schema

### SQLite Tables

```
┌──────────────────┐      ┌──────────────────┐
│  user_accounts   │      │  conversations   │
├──────────────────┤      ├──────────────────┤
│ id (PK)          │◄─┐   │ id (PK)          │
│ name             │  └───│ user_id (FK)     │
│ email (UNIQUE)   │      │ query            │
│ plan_type        │      │ response         │
│ balance          │      │ timestamp        │
│ created_at       │      │ tokens_used      │
│ last_login       │      └──────────────────┘
└──────────────────┘

┌────────────────────────────┐    ┌──────────────┐
│ knowledge_base_metadata    │    │  settings    │
├────────────────────────────┤    ├──────────────┤
│ id (PK)                    │    │ id (PK)      │
│ document_id (UNIQUE)       │    │ user_id (FK) │
│ title                      │    │ setting_key  │
│ source                     │    │ setting_val  │
│ category                   │    └──────────────┘
│ created_at                 │
│ updated_at                 │
│ metadata (JSON)            │
└────────────────────────────┘
```

### Pinecone Vector Index

```
Index: "rag-chatbot"

Vector Records:
├── Document 1
│   ├── ID: doc_123
│   ├── Embedding: [0.12, 0.45, ...] (768 dims)
│   ├── Metadata: {title, source, date}
│   └── Text: Full text content
├── Document 2
│   ├── ID: doc_456
│   └── ...
└── ...

Search Operations:
├── Similarity search (k=5)
├── Metadata filtering
└── Hybrid search
```

---

## 🔄 Workflow States (LangGraph)

```
RAG Agent Workflow
│
├─ State Definition
│  └─ messages (conversation history)
│  └─ user_id (context)
│  └─ context (additional data)
│
├─ Process Node
│  └─ Invoke agent tools
│  └─ Execute Pinecone search
│  └─ Execute SQLite search
│  └─ Call Gemini LLM
│
├─ Save Node
│  └─ Store conversation
│  └─ Update metadata
│  └─ Track tokens
│
└─ Return Response
   └─ AI generated answer
```

---

## 🛠️ Tool Architecture

```
LangGraph Tools
│
├─ Pinecone Search Tool
│  ├─ Input: User query
│  ├─ Process: Semantic similarity
│  └─ Output: Top 5 relevant docs
│
├─ SQLite Search Tool
│  ├─ Input: Keyword query
│  ├─ Process: SQL matching
│  └─ Output: Matching records
│
├─ User Profile Tool
│  ├─ Input: User ID
│  ├─ Process: Database lookup
│  └─ Output: User details
│
└─ Knowledge Add Tool
   ├─ Input: Document details
   ├─ Process: Store + embed
   └─ Output: Success status
```

---

## 📦 Deployment Architecture

```
Local Development
┌──────────────┐
│ Docker       │
│ Compose      │
│              │
│ ┌──────────┐ │
│ │ Frontend │ │
│ │ :3000    │ │
│ └─────┬────┘ │
│       │      │
│       │ HTTP │
│       ▼      │
│ ┌──────────┐ │
│ │ Backend  │ │
│ │ :8000    │ │
│ ├──────────┤ │
│ │SQLite    │ │
│ │(local)   │ │
│ └──────────┘ │
└──────────────┘

Production Deployment
┌─────────────────────┐
│  Vercel (Frontend)  │
│  yourapp.vercel.app │
└──────────┬──────────┘
           │ HTTPS
           ▼
┌─────────────────────────────┐
│   Render (Backend)          │
│  rag-chatbot.onrender.com   │
├─────────────────────────────┤
│ - Pinecone (Cloud)          │
│ - SQLite (On Render)        │
│ - Google Gemini API         │
└─────────────────────────────┘
```

---

## 🔑 API Endpoint Architecture

```
FastAPI Router Structure
│
├─ Health Endpoints
│  ├─ GET /             (server status)
│  └─ GET /health       (detailed check)
│
├─ Chat Endpoints
│  └─ POST /chat        (message processing)
│
├─ User Endpoints
│  ├─ GET /user/{id}    (profile)
│  ├─ POST /user        (create)
│  └─ GET /user/{id}/conversations  (history)
│
├─ Knowledge Endpoints
│  ├─ POST /knowledge/add       (add doc)
│  └─ GET /knowledge/metadata   (list docs)
│
└─ Documentation
   └─ GET /docs         (interactive API)
      └─ GET /redoc     (alternative docs)
```

---

## 🧠 LangChain Integration

```
LangChain Components
│
├─ LLM
│  └─ ChatGoogleGenerativeAI
│     └─ Model: gemini-2.0-flash
│
├─ Embeddings
│  └─ GoogleGenerativeAIEmbeddings
│     └─ Model: models/embedding-001
│
├─ Vector Store
│  └─ PineconeVectorStore
│     └─ Index: rag-chatbot
│
├─ Retrievers
│  ├─ Pinecone Retriever (k=5)
│  └─ Custom DB Retriever
│
├─ Tools
│  ├─ Pinecone Search Tool
│  ├─ SQLite Search Tool
│  └─ User Profile Tool
│
└─ Agent
   └─ ReActAgent with state
      └─ Uses LangGraph
```

---

## 🔄 Error Handling Flow

```
Error Occurs
    │
    ▼
┌─────────────────────────┐
│ Try/Except Block        │
│ - Identify error type   │
│ - Log details           │
└──────────────┬──────────┘
               │
        ┌──────┴──────┐
        │             │
    Error │         Error │
   Logged │          Type │
        ▼             ▼
    ┌──────────┐  ┌────────────┐
    │ Fallback │  │ HTTP Error │
    │ Response │  │ + Message  │
    └────┬─────┘  └─────┬──────┘
         │              │
         └──────┬───────┘
                │
                ▼
        User Sees Error
        Message
```

---

## 🚀 Deployment Pipeline

```
Code Repository (GitHub)
    │
    ├─ Push Code
    │   │
    │   ├─ Backend → Render
    │   │   ├─ Pull code
    │   │   ├─ Install dependencies
    │   │   ├─ Verify build
    │   │   ├─ Run migrations
    │   │   └─ Deploy
    │   │
    │   └─ Frontend → Vercel
    │       ├─ Pull code
    │       ├─ Install dependencies
    │       ├─ Build Next.js
    │       ├─ Optimize assets
    │       └─ Deploy
    │
    └─ GitHub Actions
        ├─ Run tests (optional)
        ├─ Lint code
        └─ Update docs
```

---

## 📈 Performance Architecture

```
Performance Optimization Layers
│
├─ Frontend
│  ├─ Next.js image optimization
│  ├─ Code splitting
│  ├─ Lazy loading
│  └─ Caching strategies
│
├─ Backend
│  ├─ Async/await processing
│  ├─ Connection pooling
│  ├─ Query optimization
│  └─ Caching layer
│
├─ Database
│  ├─ Pinecone indexing
│  ├─ SQLite optimization
│  ├─ Query indexing
│  └─ Connection reuse
│
└─ Network
   ├─ HTTPS/TLS
   ├─ Gzip compression
   ├─ HTTP/2
   └─ CDN (Vercel)
```

---

## 🔐 Security Architecture

```
Security Layers
│
├─ Frontend
│  ├─ No secrets in code
│  ├─ HTTPS only
│  └─ CORS headers
│
├─ Backend
│  ├─ API key validation
│  ├─ Input sanitization
│  ├─ Rate limiting
│  ├─ Error hiding
│  └─ Logging
│
├─ Data
│  ├─ Encrypted at rest
│  ├─ Encrypted in transit
│  ├─ Access control
│  └─ Audit logging
│
└─ Deployment
   ├─ Environment variables
   ├─ Secrets management
   ├─ Network isolation
   └─ Monitoring
```

---

## 📊 Monitoring & Logging

```
Monitoring Stack
│
├─ Backend Logs
│  ├─ Request logging
│  ├─ Error tracking
│  ├─ Performance metrics
│  └─ Audit trail
│
├─ Database Monitoring
│  ├─ Query performance
│  ├─ Connection count
│  ├─ Storage usage
│  └─ Error logs
│
├─ Frontend Monitoring
│  ├─ Error tracking (Sentry)
│  ├─ Performance (Web Vitals)
│  ├─ User interactions
│  └─ API calls
│
└─ Alerting
   ├─ Error threshold
   ├─ Performance degradation
   ├─ Service downtime
   └─ Resource usage
```

---

## 🎯 Summary

This architecture provides:
- ✅ Scalability through cloud deployment
- ✅ Reliability with dual databases
- ✅ Security through proper configuration
- ✅ Performance through optimization
- ✅ Maintainability through clean separation
- ✅ Monitoring through comprehensive logging

**All components are fully configured and ready to deploy!** 🚀

See other documentation:
- `LOCAL_SETUP.md` - How to run locally
- `CUSTOM_DEPLOYMENT_GUIDE.md` - Cloud deployment
- `README_NEW.md` - Complete project overview
