@echo off
REM RAG Chatbot - Start Script for Windows
REM This script starts both backend and frontend services

setlocal enabledelayedexpansion
set "YELLOW=[33m"
set "GREEN=[32m"
set "RED=[31m"
set "NC=[0m"

echo ============================================
echo     RAG Chatbot Local Development Startup
echo ============================================
echo.

REM Backend Setup
echo %YELLOW%[*] Setting up Backend...%NC%
cd Backend

REM Create virtual environment if not exists
if not exist "venv" (
    echo Creating Python virtual environment...
    python -m venv venv
)

REM Activate virtual environment
call venv\Scripts\activate.bat

REM Install dependencies
echo Installing Python dependencies...
pip install -q -r requirements.txt

REM Initialize database
echo Initializing database...
python init_db.py

REM Check for .env file
if not exist ".env" (
    echo %YELLOW%[!] .env file not found. Copying from .env.example...%NC%
    copy .env.example .env
    echo %RED%[ERROR] Please edit .env with your API keys and run this script again.%NC%
    pause
    exit /b 1
)

echo %GREEN%[OK] Backend ready!%NC%
echo.

REM Start Backend
echo %YELLOW%[*] Starting Backend (FastAPI)...%NC%
start "RAG Chatbot Backend" cmd /k "cd Backend && call venv\Scripts\activate.bat && uvicorn main:app --host 127.0.0.1 --port 8000 --reload"
timeout /t 3 /nobreak

REM Frontend Setup
echo %YELLOW%[*] Setting up Frontend...%NC%
cd ..\Frontend

REM Install dependencies if needed
if not exist "node_modules" (
    echo Installing Node dependencies...
    call npm install
)

REM Check for .env.local file
if not exist ".env.local" (
    echo Creating .env.local with development defaults...
    echo NEXT_PUBLIC_API_URL=http://localhost:8000 > .env.local
)

echo %GREEN%[OK] Frontend ready!%NC%
echo.

REM Start Frontend
echo %YELLOW%[*] Starting Frontend (Next.js)...%NC%
start "RAG Chatbot Frontend" cmd /k "npm run dev"

echo.
echo %GREEN%[SUCCESS] Services starting in separate windows!%NC%
echo.
echo [INFO] Backend running at: http://localhost:8000
echo [INFO] Frontend running at: http://localhost:3000
echo [INFO] API Documentation: http://localhost:8000/docs
echo.
echo [INFO] Check the separate command windows for logs
echo [INFO] Close the windows to stop the services
echo.
pause
