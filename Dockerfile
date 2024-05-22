# Usamos una versión específica de Ubuntu para evitar cambios inesperados
FROM ubuntu:20.04

# Actualizamos el sistema de paquetes de Ubuntu y limpiamos la caché
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instalamos Node.js y npm
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Establecemos el directorio de trabajo
WORKDIR /usr/src/app

# Copiar el 'package.json' y 'package-lock.json' de nuestro proyecto de Angular
COPY PruebaDocker/package*.json ./

# Instalar las dependencias del proyecto de Angular
RUN npm install

# Copiar los archivos restantes del proyecto de Angular
COPY PruebaDocker/ ./

# Construir el proyecto de Angular
RUN npm run build

# Copiar la configuración de Nginx
COPY default.conf /etc/nginx/conf.d/

# Exponer el puerto 80 para el servidor web
EXPOSE 80

# Comando para ejecutar nuestro de nginx
CMD ["nginx", "-g", "daemon off;"]
