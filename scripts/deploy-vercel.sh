#!/bin/bash
# Deploy script for Vercel frontend deployment

echo "🚀 Deploying RAG Chatbot Frontend to Vercel..."

# Navigate to Frontend
cd Frontend

# Install Vercel CLI if not exists
echo "📦 Installing Vercel CLI..."
npm install -g vercel

echo "🔨 Installing dependencies..."
npm install

echo "🚀 Building application..."
npm run build

echo "📤 Deploying to Vercel..."
echo ""
echo "To deploy:"
echo "1. Ensure you have a Vercel account at https://vercel.com"
echo "2. Install Vercel CLI: npm install -g vercel"
echo "3. Run: vercel --prod (from Frontend directory)"
echo ""
echo "To set up environment variables in Vercel:"
echo "1. Go to your project settings on vercel.com"
echo "2. Add environment variable: NEXT_PUBLIC_API_URL = https://<your-render-backend-url>"
echo ""
echo "✅ Frontend deployment configuration complete!"
