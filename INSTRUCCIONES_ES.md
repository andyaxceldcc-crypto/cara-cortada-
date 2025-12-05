# 🎭 Roop-Unleashed - Instrucciones en Español

## 🚀 Instalación Rápida

### Opción 1: Instalación Automática (Recomendada)

**Para Windows:**
```bash
# Descargar e instalar automáticamente
instalar.bat
```

**Para Linux/Mac:**
```bash
# Hacer ejecutable y instalar
chmod +x instalar.sh
./instalar.sh
```

**Para cualquier sistema:**
```bash
# Instalador universal en Python
python instalar.py
```

### Opción 2: Instalación Manual

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/zullum/roop-unleashed
   cd roop-unleashed
   ```

2. **Crear entorno virtual:**
   ```bash
   python -m venv roop-env
   # Windows:
   roop-env\Scripts\activate
   # Linux/Mac:
   source roop-env/bin/activate
   ```

3. **Instalar dependencias:**
   ```bash
   pip install -r requirements.txt
   ```

## 🎮 Ejecución

### Interfaz Gráfica (Recomendada)
```bash
python run.py
```
La aplicación se abrirá en tu navegador en `http://localhost:7860`

### Línea de Comandos
```bash
# Intercambio básico
python run.py -s imagen_origen.jpg -t video_objetivo.mp4 -o resultado.mp4

# Con opciones avanzadas
python run.py -s origen.jpg -t objetivo.mp4 -o resultado.mp4 --many-faces --keep-fps
```

## 📋 Características Principales

### 🔄 Intercambio de Caras
- **Imagen a Imagen**: Intercambia caras entre dos imágenes
- **Imagen a Video**: Aplica una cara a todas las caras en un video
- **Múltiples Caras**: Procesa todas las caras detectadas
- **Selección Manual**: Elige qué caras intercambiar

### 📹 Cámara en Vivo
- **Webcam en Tiempo Real**: Intercambio de caras usando tu cámara
- **Streaming**: Perfecto para videollamadas
- **Configuración Ajustable**: Calidad y velocidad personalizables

### 🎨 Mejoramiento de Caras
- **GFPGAN**: Mejora la calidad de caras generadas
- **Real-ESRGAN**: Súper resolución para mejor detalle
- **CodeFormer**: Restauración avanzada de caras

### 🛠️ Herramientas Extras
- **Cortar Videos**: Extrae segmentos específicos
- **Unir Videos**: Combina múltiples videos
- **Extraer Frames**: Convierte video a imágenes
- **Procesamiento por Lotes**: Múltiples archivos a la vez

## ⚙️ Configuración

### Configuraciones Principales
- **Calidad de Video**: Ajusta la calidad de salida (0-51)
- **Hilos de Ejecución**: Número de procesos paralelos
- **Memoria Máxima**: Límite de RAM a usar
- **Proveedor de Ejecución**: CPU, CUDA, etc.

### Modos de Intercambio
- **Primera Detectada**: Usa la primera cara encontrada
- **Todas las Caras**: Procesa todas las caras detectadas
- **Selección Manual**: Elige caras específicas
- **Por Género**: Filtra por género detectado

## 🔧 Solución de Problemas

### Problemas Comunes

**1. Error de memoria insuficiente:**
```bash
# Reducir uso de memoria
python run.py --max-memory 4
```

**2. Procesamiento muy lento:**
```bash
# Verificar si CUDA está disponible
python -c "import torch; print(torch.cuda.is_available())"

# Instalar PyTorch con CUDA
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

**3. Error de dependencias:**
```bash
# Reinstalar dependencias
pip install -r requirements.txt --force-reinstall
```

**4. La aplicación no se abre:**
```bash
# Usar puerto diferente
python run.py --server-port 7861
```

### Códigos de Error Comunes

- **Error 1**: Python no encontrado → Instalar Python 3.8+
- **Error 2**: Dependencias faltantes → Ejecutar `pip install -r requirements.txt`
- **Error 3**: GPU no detectada → Instalar drivers NVIDIA
- **Error 4**: Puerto ocupado → Cambiar puerto con `--server-port`

## 📊 Rendimiento

### Requisitos Mínimos
- **CPU**: Intel i5 / AMD Ryzen 5
- **RAM**: 8GB
- **GPU**: Opcional (NVIDIA GTX 1060+)
- **Espacio**: 5GB libres

### Requisitos Recomendados
- **CPU**: Intel i7 / AMD Ryzen 7
- **RAM**: 16GB+
- **GPU**: NVIDIA RTX 3060+
- **Espacio**: 10GB+ libres

### Optimización
- **GPU NVIDIA**: 10-50x más rápido que CPU
- **Más RAM**: Permite procesar videos más largos
- **SSD**: Mejora velocidad de carga de archivos

## 🎯 Casos de Uso

### Entretenimiento
- Crear memes divertidos
- Efectos especiales caseros
- Contenido para redes sociales

### Educativo
- Demostraciones de deepfakes
- Investigación académica
- Concienciación sobre IA

### Profesional
- Efectos visuales
- Doblaje visual
- Prototipos de personajes

## ⚠️ Consideraciones Éticas

### Uso Responsable
- ✅ **Obtén consentimiento** de las personas cuyas caras uses
- ✅ **Etiqueta claramente** el contenido como deepfake
- ✅ **Respeta la privacidad** y dignidad de otros
- ✅ **Cumple las leyes locales** de tu país

### Uso Prohibido
- ❌ **No crear contenido malicioso** o dañino
- ❌ **No usar para desinformación** o noticias falsas
- ❌ **No crear contenido sin consentimiento**
- ❌ **No violar leyes** de privacidad o derechos de imagen

## 🆘 Obtener Ayuda

### Recursos
- **Documentación**: README_ES.md
- **Issues**: [GitHub Issues](https://github.com/zullum/roop-unleashed/issues)
- **Discusiones**: [GitHub Discussions](https://github.com/zullum/roop-unleashed/discussions)

### Reportar Problemas
Al reportar un problema, incluye:
1. **Sistema operativo** y versión
2. **Versión de Python**
3. **Mensaje de error completo**
4. **Pasos para reproducir** el problema
5. **Archivos de log** si están disponibles

### Contribuir
¡Las contribuciones son bienvenidas!
1. Fork el repositorio
2. Crea una rama para tu feature
3. Haz commit de tus cambios
4. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la licencia MIT. Ver LICENSE para más detalles.

## 🙏 Créditos

- **Proyecto Original**: [roop](https://github.com/s0md3v/roop)
- **Versión Unleashed**: [C0untFloyd](https://github.com/C0untFloyd/roop-unleashed)
- **Traducción Española**: Versión modificada

---

**¡Disfruta usando roop-unleashed de manera responsable! 🎭✨**