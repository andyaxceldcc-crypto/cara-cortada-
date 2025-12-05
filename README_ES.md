# roop-unleashed - Versión en Español

[Registro de Cambios](#registro-de-cambios) • [Instalación](#instalación) • [Uso](#uso) • [Ejemplo](#ejemplo) • [Preguntas Frecuentes](#preguntas-frecuentes)

Deepfakes sin censura para imágenes y videos sin entrenamiento y con una interfaz gráfica fácil de usar.

![Pantalla](docs/screenshot.png)

### Características

- Interfaz gráfica independiente de plataforma basada en navegador
- Selección de múltiples caras de entrada/salida de una vez
- Muchos modos de intercambio diferentes: primera detectada, selecciones de caras, por género
- Procesamiento por lotes de imágenes/videos
- Enmascaramiento de oclusores faciales usando prompts de texto
- Restauración facial opcional usando diferentes mejoradores
- Vista previa de intercambio desde diferentes frames de video
- Cámara falsa en vivo usando tu webcam
- Pestaña de extras para cortar videos, etc.
- Configuraciones - almacenamiento de configuración para la próxima sesión
- Soporte de temas

y mucho más...

## Descargo de Responsabilidad

Este proyecto es solo para uso técnico y académico.
Se espera que los usuarios de este software lo usen de manera responsable cumpliendo con las leyes locales. Si se está usando la cara de una persona real, se sugiere a los usuarios obtener el consentimiento de la persona involucrada y mencionar claramente que es un deepfake al publicar contenido en línea. Los desarrolladores de este software no serán responsables de las acciones de los usuarios finales.
**Por favor no lo apliques a escenarios ilegales y no éticos.**

En caso de violación de los requisitos legales y éticos del país o región del usuario, este repositorio de código está exento de responsabilidad.

## Instalación

### Requisitos del Sistema

- **Windows**: Necesitas descargar e instalar [Visual Studio](https://visualstudio.microsoft.com/es/downloads/) (en teoría las build-tools podrían funcionar también pero en mi experiencia hasta ahora no lo hacen). Durante la instalación, asegúrate de incluir el paquete de C++.
- **Python**: Versión 3.8 o superior
- **GPU**: NVIDIA GPU con soporte CUDA (recomendado para mejor rendimiento)
- **RAM**: Mínimo 8GB, recomendado 16GB o más

### Instalación Automática (Recomendada)

Para Windows, simplemente usa el instalador de 1-click en las releases. Esto descargará e instalará todo en un entorno conda conveniente. Esto no solo instala la aplicación sino que también la ejecuta una vez instalada.

### Instalación Manual

Para otros sistemas operativos o si sabes lo que estás haciendo:

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/zullum/roop-unleashed
   cd roop-unleashed
   ```

2. **Crear entorno virtual (recomendado):**
   ```bash
   # Usando conda
   conda create -n roop python=3.10
   conda activate roop
   
   # O usando venv
   python -m venv roop-env
   # En Windows:
   roop-env\Scripts\activate
   # En Linux/Mac:
   source roop-env/bin/activate
   ```

3. **Instalar dependencias:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Instalar PyTorch con soporte CUDA (opcional pero recomendado):**
   ```bash
   # Para CUDA 11.8
   pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
   
   # Para CUDA 12.1
   pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
   ```

### Instalación de Dependencias Adicionales

Si encuentras problemas con algunas dependencias, puedes instalarlas manualmente:

```bash
# Para procesamiento de video
pip install opencv-python ffmpeg-python

# Para detección de caras
pip install insightface onnxruntime-gpu

# Para la interfaz gráfica
pip install gradio

# Para mejoramiento de caras
pip install gfpgan realesrgan
```

## Uso

### Ejecutar la Aplicación

1. **Activar el entorno virtual** (si usaste uno):
   ```bash
   # Conda
   conda activate roop
   
   # Venv en Windows
   roop-env\Scripts\activate
   
   # Venv en Linux/Mac
   source roop-env/bin/activate
   ```

2. **Ejecutar la aplicación:**
   ```bash
   python run.py
   ```

3. **Abrir en el navegador:**
   La aplicación se abrirá automáticamente en tu navegador predeterminado en `http://localhost:7860`

### Uso desde Línea de Comandos

También puedes usar roop-unleashed desde la línea de comandos:

```bash
# Intercambio básico de caras
python run.py -s imagen_origen.jpg -t video_objetivo.mp4 -o resultado.mp4

# Con opciones adicionales
python run.py -s imagen_origen.jpg -t video_objetivo.mp4 -o resultado.mp4 --keep-fps --many-faces
```

### Opciones de Línea de Comandos

- `-s, --source`: Seleccionar una imagen origen
- `-t, --target`: Seleccionar una imagen o video objetivo
- `-o, --output`: Seleccionar archivo o directorio de salida
- `-f, --folder`: Seleccionar carpeta objetivo para procesamiento en lote
- `--keep-fps`: Mantener fps objetivo
- `--keep-frames`: Mantener frames temporales
- `--skip-audio`: Omitir audio objetivo
- `--many-faces`: Procesar todas las caras
- `--max-memory`: Cantidad máxima de RAM en GB
- `--execution-threads`: Número de hilos de ejecución

## Características Principales

### 1. Intercambio de Caras
- Selecciona una imagen origen con la cara que quieres usar
- Selecciona un video o imagen objetivo donde quieres aplicar la cara
- Elige el modo de intercambio (primera detectada, selección manual, por género)

### 2. Cámara en Vivo
- Usa tu webcam para intercambio de caras en tiempo real
- Perfecto para videollamadas o streaming

### 3. Procesamiento por Lotes
- Procesa múltiples archivos a la vez
- Ideal para proyectos grandes

### 4. Mejoramiento de Caras
- Usa diferentes algoritmos para mejorar la calidad de las caras
- GFPGAN, Real-ESRGAN y más

### 5. Herramientas Extras
- Cortar videos
- Unir videos
- Extraer frames
- Y más utilidades

## Solución de Problemas

### Problemas Comunes

1. **Error de memoria insuficiente:**
   - Reduce la resolución del video
   - Usa `--max-memory` para limitar el uso de RAM
   - Cierra otras aplicaciones

2. **Procesamiento lento:**
   - Asegúrate de tener PyTorch con CUDA instalado
   - Verifica que tu GPU esté siendo utilizada
   - Aumenta `--execution-threads`

3. **Error de dependencias:**
   - Reinstala las dependencias: `pip install -r requirements.txt --force-reinstall`
   - Verifica que tienes Python 3.8 o superior

4. **La aplicación no se abre:**
   - Verifica que el puerto 7860 no esté en uso
   - Intenta ejecutar con `python run.py --server-port 7861`

### Obtener Ayuda

Si tienes problemas:
1. Revisa las [Issues](https://github.com/zullum/roop-unleashed/issues) en GitHub
2. Crea una nueva issue con detalles del problema
3. Incluye tu sistema operativo, versión de Python y mensaje de error completo

## Contribuir

¡Las contribuciones son bienvenidas! Por favor:
1. Haz fork del repositorio
2. Crea una rama para tu característica
3. Haz commit de tus cambios
4. Haz push a la rama
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo LICENSE para más detalles.

## Créditos

- Proyecto original: [roop](https://github.com/s0md3v/roop)
- Versión unleashed: [C0untFloyd](https://github.com/C0untFloyd/roop-unleashed)
- Traducción al español: Versión modificada

---

**Nota**: Esta es una versión traducida y modificada del proyecto original. Asegúrate de cumplir con todas las leyes locales y usar esta herramienta de manera ética y responsable.