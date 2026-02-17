# Verba Backend API - Dockerfile
FROM python:3.11-slim

WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiar archivos necesarios para la instalación
COPY setup.py setup.py
COPY README.md README.md
COPY MANIFEST.in MANIFEST.in
COPY goldenverba/ goldenverba/

RUN pip install --no-cache-dir '.'

# Exponer puerto API
EXPOSE 8000

# Ejecutar API backend
CMD ["verba", "start", "--port", "8000", "--host", "0.0.0.0"]
