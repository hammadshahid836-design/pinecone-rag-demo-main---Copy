# RAG Chatbot Deployment and Setup Guide

## Project Structure
```
pinecone-rag-demo/
├── Backend/
│   ├── main.py                 # FastAPI application
│   ├── database_service.py     # SQLite database management
│   ├── rag_agent.py           # LangGraph RAG implementation
│   ├── init_db.py             # Database initialization
│   ├── requirements.txt        # Python dependencies
│   ├── .env.example           # Environment template
│   ├── render.yaml            # Render deployment config
│   └── .gitignore
├── Frontend/
│   ├── next.config.js
│   ├── package.json
│   ├── vercel.json            # Vercel deployment config
│   ├── tsconfig.json
│   └── src/
└── scripts/
    ├── deploy-render.sh       # Render deployment script
    └── deploy-vercel.sh       # Vercel deployment script

```

## Quick Setup

### 1. Local Development

```bash