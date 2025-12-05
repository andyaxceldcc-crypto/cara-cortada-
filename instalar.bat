@echo off
chcp 65001 >nul
title Instalador de roop-unleashed en Español

echo ================================================================
echo 🎭 ROOP-UNLEASHED - INSTALADOR AUTOMÁTICO EN ESPAÑOL 🎭
echo ================================================================
echo Este script instalará automáticamente todas las dependencias
echo necesarias para ejecutar roop-unleashed en Windows.
echo ================================================================
echo.

echo 🔍 Verificando Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Error: Python no está instalado o no está en el PATH
    echo    Por favor instala Python 3.8 o superior desde:
    echo    https://www.python.org/downloads/
    pause
    exit /b 1
)

echo ✅ Python encontrado
python --version

echo.
echo ⚠️  IMPORTANTE:
echo    Asegúrate de tener Visual Studio instalado con el paquete C++
echo    Descárgalo desde: https://visualstudio.microsoft.com/es/downloads/
echo.
pause

echo 🔄 Actualizando pip...
python -m pip install --upgrade pip

echo 📦 Instalando dependencias principales...
python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

echo 📦 Instalando requirements.txt...
if exist requirements.txt (
    python -m pip install -r requirements.txt
) else (
    echo ⚠️  requirements.txt no encontrado, instalando paquetes básicos...
    python -m pip install opencv-python gradio insightface onnxruntime-gpu gfpgan realesrgan ffmpeg-python Pillow numpy requests tqdm
)

echo 🎮 Verificando GPU NVIDIA...
nvidia-smi >nul 2>&1
if errorlevel 1 (
    echo ⚠️  No se detectó GPU NVIDIA - se usará CPU ^(más lento^)
) else (
    echo ✅ GPU NVIDIA detectada - se usará aceleración por GPU
)

echo 🚀 Creando script de ejecución...
echo @echo off > ejecutar.bat
echo echo Iniciando roop-unleashed... >> ejecutar.bat
echo python run.py >> ejecutar.bat
echo pause >> ejecutar.bat

echo 🧪 Probando instalación...
python -c "import torch, cv2, gradio; print('✅ Dependencias principales OK')" 2>nul
if errorlevel 1 (
    echo ❌ Error en la instalación - algunas dependencias faltan
    echo    Intenta ejecutar: python instalar.py
    pause
    exit /b 1
)

echo.
echo ================================================================
echo 🎉 ¡INSTALACIÓN COMPLETADA EXITOSAMENTE! 🎉
echo ================================================================
echo Para ejecutar roop-unleashed:
echo 1. Ejecuta: python run.py
echo 2. O usa el script: ejecutar.bat
echo.
echo La aplicación se abrirá en tu navegador en http://localhost:7860
echo.
echo ⚠️  RECORDATORIO IMPORTANTE:
echo    - Usa esta herramienta de manera ética y responsable
echo    - Obtén consentimiento antes de usar caras de personas reales
echo    - Cumple con las leyes locales de tu país
echo ================================================================
echo.

set /p respuesta="¿Quieres ejecutar roop-unleashed ahora? (s/n): "
if /i "%respuesta%"=="s" (
    echo 🚀 Iniciando roop-unleashed...
    python run.py
) else if /i "%respuesta%"=="si" (
    echo 🚀 Iniciando roop-unleashed...
    python run.py
)

pause