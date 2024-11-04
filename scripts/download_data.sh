#!/bin/bash

# Cambiar a la raiz del repositorio si se ejecuta desde el directorio 'scripts'
if [[ $(basename "$PWD") == "scripts" ]]; then
    cd ..
fi

# Verificar si kaggle.json existe
if [[ ! -f ~/.kaggle/kaggle.json ]]; then
    echo "Error: No se encontro kaggle.json."
    echo "Por favor, sigue estos pasos para obtenerlo:"
    echo "1. Inicia sesion en Kaggle."
    echo "2. Ve a tu perfil y selecciona 'Settings'."
    echo "3. En la seccion 'API', haz clic en 'Create New Token'."
    echo "4. Mueve el archivo kaggle.json a ~/.kaggle/"
    echo "5. Asegurate de que tenga los permisos correctos (chmod 600 ~/.kaggle/kaggle.json)."
    exit 1
fi

# Crear el directorio 'data' si no existe
if [[ ! -d "data/raw" ]]; then
    mkdir -p data/raw
    echo "Directorio 'data/raw' creado."
fi

# Descargar datos de Kaggle
echo "Descargando datos de Kaggle..."
kaggle competitions download -c jigsaw-unintended-bias-in-toxicity-classification

# Verificar si la descarga fue exitosa
if [[ -f "jigsaw-unintended-bias-in-toxicity-classification.zip" ]]; then
    echo "Descarga completada."

    # Descomprimir los archivos descargados
    unzip -o jigsaw-unintended-bias-in-toxicity-classification.zip -d data/raw
    
    # Eliminar el archivo zip despues de descomprimir
    rm jigsaw-unintended-bias-in-toxicity-classification.zip
    echo "Archivo ZIP eliminado despues de la descompresion."
else
    echo "Error: La descarga no se completo. Verifica que tengas acceso a Kaggle y que el dataset exista."
fi
