# Bravo Pablo Prueba Docker

1. Usamos una versión específica de Ubuntu para evitar cambios inesperados
```bash
FROM ubuntu:20.04
```
2. Actualizamos el sistema de paquetes de Ubuntu y limpiamos la caché
```bash
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    && rm -rf /var/lib/apt/lists/*
```
3. Instalamos Node.js y npm
```bash
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs
```
4. Establecemos el directorio de trabajo
```bash
WORKDIR /usr/src/app

# Copiar el 'package.json' y 'package-lock.json' de nuestro proyecto de Angular
```bash
COPY PruebaDocker/package*.json ./
```
5. Instalar las dependencias del proyecto de Angular
```bash
RUN npm install
```
6. Copiar los archivos restantes del proyecto de Angular
```bash
COPY PruebaDocker/ ./
```
7. Construir el proyecto de Angular
```bash
RUN npm run build
```
8. Copiar la configuración de Nginx
```bash
COPY default.conf /etc/nginx/conf.d/
```
9. Exponer el puerto 80 para el servidor web
```bash
EXPOSE 80
```
10. Comando para ejecutar nuestro de nginx
```bash
CMD ["nginx", "-g", "daemon off;"]
```
