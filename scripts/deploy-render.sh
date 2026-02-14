#!/bin/bash
# Deploy script for Render backend deployment

echo "🚀 Deploying RAG Chatbot Backend to Render..."

# Install Render CLI
echo "📦 Installing Render CLI..."
npm install -g @render/cli

# Login to Render
echo "🔐 Logging in to Render..."
echo "Please ensure you have set the following environment variables in Render dashboard:"
echo "  - GOOGLE_API_KEY"
echo "  - PINECONE_API_KEY"

# Build the project
echo "🔨 Building Python dependencies..."
pip install -r Backend/requirements.txt

# Run database initialization
echo "🗄️ Initializing database..."
cd Backend
python init_db.py
cd ..

echo "✅ Deployment preparation complete!"
echo ""
echo "Next steps:"
echo "1. Push this code to your Git repository (GitHub, GitLab, etc.)"
echo "2. Create a new Web Service on Render.com"
echo "3. Connect your Git repository"
echo "4. Set the following build command: pip install -r Backend/requirements.txt"
echo "5. Set the following start command: cd Backend && uvicorn main:app --host 0.0.0.0 --port $PORT"
echo "6. Add environment variables in Render dashboard"
echo "7. Deploy!"
