# Usamos Nginx para servir archivos estáticos
FROM nginx:alpine

# Copiamos todo el contenido de la carpeta actual al directorio público de Nginx
COPY . /usr/share/nginx/html

# Exponemos el puerto 80 (donde escucha Nginx)
EXPOSE 80
