FROM nginx:1.25-alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Crear un HTML básico para la prueba del frontend
RUN mkdir -p /usr/share/nginx/html && \
    echo '<h1>Plataforma de Reservas Culturales de Sevilla</h1>' > /usr/share/nginx/html/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
