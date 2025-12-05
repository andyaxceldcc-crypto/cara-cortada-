#!/bin/bash

# Script de instalación para roop-unleashed en español (Linux/Mac)

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_banner() {
    echo "================================================================"
    echo "🎭 ROOP-UNLEASHED - INSTALADOR AUTOMÁTICO EN ESPAÑOL 🎭"
    echo "================================================================"
    echo "Este script instalará automáticamente todas las dependencias"
    echo "necesarias para ejecutar roop-unleashed en tu sistema."
    echo "================================================================"
    echo
}

check_python() {
    echo -e "${BLUE}🔍 Verificando Python...${NC}"
    
    if ! command -v python3 &> /dev/null; then
        if ! command -v python &> /dev/null; then
            echo -e "${RED}❌ Error: Python no está instalado${NC}"
            echo "   Por favor instala Python 3.8 o superior"
            exit 1
        else
            PYTHON_CMD="python"
        fi
    else
        PYTHON_CMD="python3"
    fi
    
    # Verificar versión
    version=$($PYTHON_CMD --version 2>&1 | grep -oE '[0-9]+\.[0-9]+')
    major=$(echo $version | cut -d. -f1)
    minor=$(echo $version | cut -d. -f2)
    
    if [ "$major" -lt 3 ] || ([ "$major" -eq 3 ] && [ "$minor" -lt 8 ]); then
        echo -e "${RED}❌ Error: Se requiere Python 3.8 o superior${NC}"
        echo "   Versión actual: $version"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Python $version - Compatible${NC}"
}

check_system() {
    echo -e "${BLUE}🔍 Detectando sistema operativo...${NC}"
    OS=$(uname -s)
    echo -e "${GREEN}✅ Sistema detectado: $OS${NC}"
    
    # Verificar dependencias del sistema
    if [[ "$OS" == "Linux" ]]; then
        echo -e "${YELLOW}⚠️  Para Linux, asegúrate de tener instalado:${NC}"
        echo "   - build-essential"
        echo "   - python3-dev"
        echo "   - libgl1-mesa-glx"
        echo "   - libglib2.0-0"
        
        # Intentar instalar dependencias automáticamente
        if command -v apt-get &> /dev/null; then
            echo -e "${BLUE}🔧 Instalando dependencias del sistema...${NC}"
            sudo apt-get update
            sudo apt-get install -y build-essential python3-dev python3-pip libgl1-mesa-glx libglib2.0-0
        elif command -v yum &> /dev/null; then
            echo -e "${BLUE}🔧 Instalando dependencias del sistema...${NC}"
            sudo yum install -y gcc gcc-c++ python3-devel python3-pip mesa-libGL glib2
        fi
    fi
}

install_packages() {
    echo -e "${BLUE}📦 Instalando dependencias de Python...${NC}"
    
    # Actualizar pip
    echo -e "${BLUE}🔄 Actualizando pip...${NC}"
    $PYTHON_CMD -m pip install --upgrade pip
    
    # Instalar PyTorch con CUDA
    echo -e "${BLUE}🔥 Instalando PyTorch con soporte CUDA...${NC}"
    $PYTHON_CMD -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
    
    # Instalar desde requirements.txt si existe
    if [ -f "requirements.txt" ]; then
        echo -e "${BLUE}📋 Instalando desde requirements.txt...${NC}"
        $PYTHON_CMD -m pip install -r requirements.txt
    else
        echo -e "${YELLOW}⚠️  requirements.txt no encontrado, instalando paquetes básicos...${NC}"
        $PYTHON_CMD -m pip install opencv-python gradio insightface onnxruntime-gpu gfpgan realesrgan ffmpeg-python Pillow numpy requests tqdm
    fi
}

check_gpu() {
    echo -e "${BLUE}🎮 Verificando GPU NVIDIA...${NC}"
    if command -v nvidia-smi &> /dev/null; then
        if nvidia-smi &> /dev/null; then
            echo -e "${GREEN}✅ GPU NVIDIA detectada${NC}"
            echo -e "${GREEN}🚀 Se usará aceleración por GPU para mejor rendimiento${NC}"
            return 0
        fi
    fi
    echo -e "${YELLOW}⚠️  No se detectó GPU NVIDIA - se usará CPU (más lento)${NC}"
    return 1
}

create_launch_script() {
    echo -e "${BLUE}🚀 Creando script de lanzamiento...${NC}"
    
    cat > ejecutar.sh << 'EOF'
#!/bin/bash
echo "Iniciando roop-unleashed..."
python3 run.py 2>/dev/null || python run.py
EOF
    
    chmod +x ejecutar.sh
    echo -e "${GREEN}✅ Script de lanzamiento creado: ejecutar.sh${NC}"
}

test_installation() {
    echo -e "${BLUE}🧪 Probando la instalación...${NC}"
    
    if $PYTHON_CMD -c "import torch, cv2, gradio; print('✅ Dependencias principales OK')" 2>/dev/null; then
        echo -e "${GREEN}✅ Dependencias principales importadas correctamente${NC}"
        
        # Verificar PyTorch CUDA
        if $PYTHON_CMD -c "import torch; print('✅ PyTorch con CUDA disponible') if torch.cuda.is_available() else print('⚠️  PyTorch sin CUDA - se usará CPU')" 2>/dev/null; then
            return 0
        fi
    else
        echo -e "${RED}❌ Error importando dependencias${NC}"
        return 1
    fi
}

main() {
    print_banner
    
    # Verificaciones del sistema
    check_python
    check_system
    
    # Instalar dependencias
    install_packages
    
    # Verificar GPU
    check_gpu
    
    # Crear script de lanzamiento
    create_launch_script
    
    # Probar instalación
    if test_installation; then
        echo
        echo "================================================================"
        echo -e "${GREEN}🎉 ¡INSTALACIÓN COMPLETADA EXITOSAMENTE! 🎉${NC}"
        echo "================================================================"
        echo "Para ejecutar roop-unleashed:"
        echo "1. Ejecuta: python3 run.py (o python run.py)"
        echo "2. O usa el script: ./ejecutar.sh"
        echo
        echo "La aplicación se abrirá en tu navegador en http://localhost:7860"
        echo
        echo -e "${YELLOW}⚠️  RECORDATORIO IMPORTANTE:${NC}"
        echo "   - Usa esta herramienta de manera ética y responsable"
        echo "   - Obtén consentimiento antes de usar caras de personas reales"
        echo "   - Cumple con las leyes locales de tu país"
        echo "================================================================"
        
        # Preguntar si quiere ejecutar ahora
        echo
        read -p "¿Quieres ejecutar roop-unleashed ahora? (s/n): " respuesta
        if [[ "$respuesta" =~ ^[SsYy]$ ]]; then
            echo -e "${GREEN}🚀 Iniciando roop-unleashed...${NC}"
            $PYTHON_CMD run.py
        fi
    else
        echo
        echo "================================================================"
        echo -e "${RED}❌ INSTALACIÓN INCOMPLETA${NC}"
        echo "================================================================"
        echo "Hubo algunos errores durante la instalación."
        echo "Por favor revisa los mensajes de error anteriores."
        echo "Puedes intentar:"
        echo "1. Ejecutar el instalador nuevamente"
        echo "2. Instalar manualmente: pip install -r requirements.txt"
        echo "3. Buscar ayuda en: https://github.com/zullum/roop-unleashed/issues"
        exit 1
    fi
}

# Manejar Ctrl+C
trap 'echo -e "\n\n${RED}❌ Instalación cancelada por el usuario${NC}"; exit 1' INT

# Ejecutar función principal
main