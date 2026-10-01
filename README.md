# Plataforma de Reservas Culturales de Sevilla

Solución de despliegue en contenedores Docker para la gestión de reservas culturales.
- **Diagrama de arquitectura**
- ## Arquitectura del Sistema

```mermaid
graph TD
    subgraph CLIENTE [" 🌐 Cliente / Navegador "]
        User["Usuario / Navegador Web"]
    end

    subgraph DOCKER [" 🐳 Docker Network (red-reservas) "]
        
        subgraph WEB_CONTAINER [" Contenedor: reservas_web "]
            Nginx["Nginx (Puerto Interno 80)"]
            StaticFiles["/usr/share/nginx/html<br>(index.html)"]
        end

        subgraph API_CONTAINER [" Contenedor: reservas_api "]
            Express["Node.js / Express API<br>(Puerto Interno 3000)"]
            AppLogic["Rutas & Lógica de Negocio<br>(/api/eventos, /api/reservas)"]
        end

        subgraph DB_CONTAINER [" Contenedor: reservas_db "]
            MySQL["MySQL Database 8.0<br>(Puerto Interno 3306)"]
            InitDB["init.sql<br>(Tablas e Inserciones)"]
        end

        subgraph VOLUMES [" 💾 Persistencia & Volúmenes "]
            VolWeb[("./web (Volumen Bind)")]
            VolDB[("db_data (Volumen Docker)")]
        end
    end

    User -->|http://localhost:80| Nginx
    User -->|http://localhost:3000| Express

    Nginx -->|Sirve archivos| StaticFiles
    Nginx -->|Reverse Proxy /api/| Express
    
    Express -->|Consultas SQL / TCP 3306| MySQL
    
    VolWeb -.->|Mapeado a| StaticFiles
    MySQL -.->|Almacena datos en| VolDB
    InitDB -.->|Ejecuta al inicio| MySQL

    style CLIENTE fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style DOCKER fill:#f5f5f5,stroke:#616161,stroke-width:2px,stroke-dasharray: 5 5
    style WEB_CONTAINER fill:#e8f5e9,stroke:#388e3c,stroke-width:2px
    style API_CONTAINER fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    style DB_CONTAINER fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    style VOLUMES fill:#eceff1,stroke:#455a64,stroke-width:2px
```

## Estructura y Arquitectura
- **Nginx (Web/Proxy):** Expuesto al puerto `80`.
- **API (Node.js):** Puerto interno `3000` (sin exponer al host).
- **Base de Datos (MySQL 8.0):** Puerto interno `3306` (sin exponer al host) con persistencia de datos.

## Despliegue Rápido
1. Copia de credenciales: `cp .env.example .env`
2. Construir y arrancar: `docker compose up --build -d`

## Pruebas de Verificación
- **Estado de contenedores:** `docker compose ps`
- **Prueba API Health:** `curl -i http://localhost/api/health`
- **Prueba Base de Datos:** `curl -i http://localhost/api/reservas`

## Prueba de Persistencia de Datos
1. `docker compose stop db && docker compose rm -f db`
2. `docker compose up -d db`
3. `curl -i http://localhost/api/reservas` (los datos siguen existiendo).
