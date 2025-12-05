#!/usr/bin/env python3
"""
Script de instalación automatizada para roop-unleashed en español
Instala todas las dependencias necesarias y configura el entorno
"""

import os
import sys
import subprocess
import platform
import urllib.request
import zipfile
import shutil
from pathlib import Path

def print_banner():
    """Muestra el banner de bienvenida"""
    print("=" * 60)
    print("🎭 ROOP-UNLEASHED - INSTALADOR AUTOMÁTICO EN ESPAÑOL 🎭")
    print("=" * 60)
    print("Este script instalará automáticamente todas las dependencias")
    print("necesarias para ejecutar roop-unleashed en tu sistema.")
    print("=" * 60)
    print()

def check_python_version():
    """Verifica que la versión de Python sea compatible"""
    print("🔍 Verificando versión de Python...")
    version = sys.version_info
    if version.major < 3 or (version.major == 3 and version.minor < 8):
        print("❌ Error: Se requiere Python 3.8 o superior")
        print(f"   Versión actual: {version.major}.{version.minor}.{version.micro}")
        print("   Por favor instala una versión más reciente de Python")
        sys.exit(1)
    print(f"✅ Python {version.major}.{version.minor}.{version.micro} - Compatible")

def check_system():
    """Verifica el sistema operativo"""
    print("🔍 Detectando sistema operativo...")
    system = platform.system()
    print(f"✅ Sistema detectado: {system}")
    
    if system == "Windows":
        print("⚠️  IMPORTANTE para Windows:")
        print("   Asegúrate de tener Visual Studio instalado con el paquete C++")
        print("   Descárgalo desde: https://visualstudio.microsoft.com/es/downloads/")
        input("   Presiona Enter para continuar...")
    
    return system

def run_command(command, description, check_error=True):
    """Ejecuta un comando del sistema"""
    print(f"🔧 {description}...")
    try:
        result = subprocess.run(command, shell=True, check=check_error, 
                              capture_output=True, text=True)
        if result.returncode == 0:
            print(f"✅ {description} - Completado")
            return True
        else:
            print(f"❌ Error en {description}")
            print(f"   Comando: {command}")
            print(f"   Error: {result.stderr}")
            return False
    except subprocess.CalledProcessError as e:
        print(f"❌ Error ejecutando: {command}")
        print(f"   Error: {e}")
        return False

def install_pip_packages():
    """Instala los paquetes de Python necesarios"""
    print("📦 Instalando dependencias de Python...")
    
    # Lista de paquetes esenciales
    packages = [
        "torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118",
        "opencv-python",
        "gradio",
        "insightface",
        "onnxruntime-gpu",
        "gfpgan",
        "realesrgan",
        "ffmpeg-python",
        "Pillow",
        "numpy",
        "requests",
        "tqdm"
    ]
    
    # Instalar requirements.txt si existe
    if os.path.exists("requirements.txt"):
        print("📋 Instalando desde requirements.txt...")
        if not run_command(f"{sys.executable} -m pip install -r requirements.txt", 
                          "Instalación desde requirements.txt"):
            print("⚠️  Continuando con instalación manual...")
    
    # Instalar paquetes individuales
    for package in packages:
        if not run_command(f"{sys.executable} -m pip install {package}", 
                          f"Instalando {package.split()[0]}"):
            print(f"⚠️  Falló la instalación de {package.split()[0]}, continuando...")

def check_gpu():
    """Verifica si hay GPU NVIDIA disponible"""
    print("🎮 Verificando GPU NVIDIA...")
    try:
        result = subprocess.run("nvidia-smi", shell=True, capture_output=True, text=True)
        if result.returncode == 0:
            print("✅ GPU NVIDIA detectada")
            print("🚀 Se usará aceleración por GPU para mejor rendimiento")
            return True
        else:
            print("⚠️  No se detectó GPU NVIDIA")
            print("   La aplicación funcionará con CPU (más lento)")
            return False
    except:
        print("⚠️  No se pudo verificar GPU NVIDIA")
        return False

def create_launch_script():
    """Crea un script de lanzamiento"""
    print("🚀 Creando script de lanzamiento...")
    
    if platform.system() == "Windows":
        script_content = """@echo off
echo Iniciando roop-unleashed...
python run.py
pause
"""
        script_name = "ejecutar.bat"
    else:
        script_content = """#!/bin/bash
echo "Iniciando roop-unleashed..."
python run.py
"""
        script_name = "ejecutar.sh"
    
    try:
        with open(script_name, 'w', encoding='utf-8') as f:
            f.write(script_content)
        
        if platform.system() != "Windows":
            os.chmod(script_name, 0o755)
        
        print(f"✅ Script de lanzamiento creado: {script_name}")
        return script_name
    except Exception as e:
        print(f"❌ Error creando script de lanzamiento: {e}")
        return None

def download_models():
    """Descarga modelos necesarios si no existen"""
    print("🤖 Verificando modelos...")
    
    models_dir = Path("models")
    if not models_dir.exists():
        models_dir.mkdir()
        print("📁 Directorio de modelos creado")
    
    # Lista de modelos básicos (se descargarán automáticamente al usar la app)
    print("ℹ️  Los modelos se descargarán automáticamente al usar la aplicación")

def test_installation():
    """Prueba la instalación"""
    print("🧪 Probando la instalación...")
    
    try:
        # Probar imports básicos
        import torch
        import cv2
        import gradio
        print("✅ Dependencias principales importadas correctamente")
        
        # Verificar PyTorch
        if torch.cuda.is_available():
            print(f"✅ PyTorch con CUDA disponible - GPU: {torch.cuda.get_device_name(0)}")
        else:
            print("⚠️  PyTorch sin CUDA - se usará CPU")
        
        return True
    except ImportError as e:
        print(f"❌ Error importando dependencias: {e}")
        return False

def main():
    """Función principal del instalador"""
    print_banner()
    
    # Verificaciones del sistema
    check_python_version()
    system = check_system()
    
    # Actualizar pip
    print("🔄 Actualizando pip...")
    run_command(f"{sys.executable} -m pip install --upgrade pip", "Actualización de pip")
    
    # Instalar dependencias
    install_pip_packages()
    
    # Verificar GPU
    has_gpu = check_gpu()
    
    # Crear script de lanzamiento
    launch_script = create_launch_script()
    
    # Descargar modelos
    download_models()
    
    # Probar instalación
    if test_installation():
        print("\n" + "=" * 60)
        print("🎉 ¡INSTALACIÓN COMPLETADA EXITOSAMENTE! 🎉")
        print("=" * 60)
        print("Para ejecutar roop-unleashed:")
        print("1. Ejecuta: python run.py")
        if launch_script:
            print(f"2. O usa el script: {launch_script}")
        print("\nLa aplicación se abrirá en tu navegador en http://localhost:7860")
        print("\n⚠️  RECORDATORIO IMPORTANTE:")
        print("   - Usa esta herramienta de manera ética y responsable")
        print("   - Obtén consentimiento antes de usar caras de personas reales")
        print("   - Cumple con las leyes locales de tu país")
        print("=" * 60)
        
        # Preguntar si quiere ejecutar ahora
        response = input("\n¿Quieres ejecutar roop-unleashed ahora? (s/n): ").lower()
        if response in ['s', 'si', 'sí', 'y', 'yes']:
            print("🚀 Iniciando roop-unleashed...")
            os.system("python run.py")
    else:
        print("\n" + "=" * 60)
        print("❌ INSTALACIÓN INCOMPLETA")
        print("=" * 60)
        print("Hubo algunos errores durante la instalación.")
        print("Por favor revisa los mensajes de error anteriores.")
        print("Puedes intentar:")
        print("1. Ejecutar el instalador nuevamente")
        print("2. Instalar manualmente: pip install -r requirements.txt")
        print("3. Buscar ayuda en: https://github.com/zullum/roop-unleashed/issues")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n❌ Instalación cancelada por el usuario")
        sys.exit(1)
    except Exception as e:
        print(f"\n\n❌ Error inesperado: {e}")
        print("Por favor reporta este error en GitHub")
        sys.exit(1)