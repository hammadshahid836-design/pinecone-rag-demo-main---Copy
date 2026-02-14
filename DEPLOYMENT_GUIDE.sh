#!/bin/bash
# Complete deployment script

echo "🚀 RAG Chatbot Complete Deployment Script"
echo "=========================================="
echo ""

# Check if running from project root
if [ ! -d "Backend" ] || [ ! -d "Frontend" ]; then
    echo "❌ Please run this script from the project root directory"
    exit 1
fi

# Backend Deployment
echo "📘 BACKEND DEPLOYMENT"
echo "-------------------"
echo "1. Create account on Render.com"
echo "2. Create GitHub repository with this code"
echo "3. In Render dashboard, create New Web Service"
echo "4. Connect your GitHub repository"
echo "5. Set Build Command:"
echo "   pip install -r Backend/requirements.txt"
echo "6. Set Start Command:"
echo "   cd Backend && uvicorn main:app --host 0.0.0.0 --port \$PORT"
echo "7. Add Environment Variables:"
echo "   - GOOGLE_API_KEY"
echo "   - PINECONE_API_KEY"
echo "   - PINECONE_INDEX_NAME=rag-chatbot"
echo "   - ENVIRONMENT=production"
echo ""

# Frontend Deployment
echo "🎨 FRONTEND DEPLOYMENT"
echo "---------------------"
echo "1. Create account on Vercel.com"
echo "2. Create GitHub repository (same repo as backend)"
echo "3. In Vercel dashboard, new project"
echo "4. Select 'Next.js' framework"
echo "5. Set root directory to 'Frontend'"
echo "6. Add Environment Variables:"
echo "   - NEXT_PUBLIC_API_URL=https://<your-render-backend-url>"
echo ""

# Generate deployment checklist
echo "✅ DEPLOYMENT CHECKLIST"
echo "---------------------"
echo "Backend:"
echo "  [ ] GitHub repository created and pushed"
echo "  [ ] Render account created"
echo "  [ ] Web Service created in Render"
echo "  [ ] Environment variables set in Render"
echo "  [ ] Build and start commands configured"
echo "  [ ] Backend URL noted (e.g., https://rag-chatbot.onrender.com)"
echo ""
echo "Frontend:"
echo "  [ ] Vercel account created"
echo "  [ ] Project created in Vercel"
echo "  [ ] GitHub repository connected"
echo "  [ ] Root directory set to 'Frontend'"
echo "  [ ] NEXT_PUBLIC_API_URL environment variable set"
echo "  [ ] Deployment successful"
echo ""

echo "📚 Documentation:"
echo "  Render: https://render.com/docs"
echo "  Vercel: https://vercel.com/docs"
echo "  LangChain: https://python.langchain.com/docs"
echo "  LangGraph: https://langchain-ai.github.io/langgraph/"
echo ""
echo "✨ Good luck with your deployment! ✨"
