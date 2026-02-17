# Verba Backend API - Docker Deployment Guide

## Quickstart

### 1. Configurar variables de entorno

```bash
cp .env.example .env
```

Edita `.env` y agrega tu **OPENAI_API_KEY**:

```env
OPENAI_API_KEY=sk-your-key-here
```

### 2. Levantar los servicios

```bash
docker-compose up -d
```

Esto inicia:
- **Verba API** en `http://localhost:8000`
- **Weaviate** en `http://localhost:8080`

### 3. Acceder a la API

- **Documentación interactiva**: http://localhost:8000/docs
- **Spec OpenAPI**: http://localhost:8000/openapi.json
- **Health check**: http://localhost:8000/api/health

## Variables de Entorno

| Variable | Requerido | Descripción |
|----------|-----------|-------------|
| `OPENAI_API_KEY` | ✅ | API key de OpenAI para embeddings/generación |
| `COHERE_API_KEY` | ❌ | API key de Cohere (alternativa a OpenAI) |
| `GROQ_API_KEY` | ❌ | API key de Groq para generación |
| `ANTHROPIC_API_KEY` | ❌ | API key de Anthropic (Claude) |
| `OLLAMA_URL` | ❌ | URL local de Ollama (ej: http://host.docker.internal:11434) |
| `GITHUB_TOKEN` | ❌ | Token para importar repos desde GitHub |
| `VERBA_PRODUCTION` | ❌ | Modo: Local (default), Docker, Demo |

## Comandos útiles

### Ver logs de verba
```bash
docker-compose logs -f verba
```

### Ver logs de weaviate
```bash
docker-compose logs -f weaviate
```

### Detener servicios
```bash
docker-compose down
```

### Eliminar datos persistidos
```bash
docker-compose down -v
```

### Reconstruir imagen
```bash
docker-compose up -d --build
```

## Ejemplo de llamada a la API

```bash
# Health check
curl http://localhost:8000/api/health

# Conectar
curl -X POST http://localhost:8000/api/connect \
  -H "Content-Type: application/json" \
  -d '{
    "credentials": {
      "deployment": "Local",
      "url": "",
      "key": ""
    },
    "port": ""
  }'
```

## Solución de problemas

### "Failed to connect to Weaviate"
Espera a que Weaviate esté completamente listo (~15-30 segundos)

### "OPENAI_API_KEY not set"
Verifica que hayas configurado la variable en `.env` antes de levantar los servicios

### Puerto 8000 ya en uso
```bash
docker-compose up -d --no-deps --build --remove-orphans
# O cambia el puerto en docker-compose.yml
```

## Documentación API

Una vez levantado, accede a http://localhost:8000/docs para ver:
- Todos los endpoints disponibles
- Esquemas de request/response
- Pruebas interactivas
