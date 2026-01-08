# Etapa 1: Construcción
FROM node:lts AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Servidor Nginx (Ligero y rápido)
FROM nginx:alpine
# Copiamos los archivos generados por Astro a la carpeta pública de Nginx
COPY --from=build /app/dist /usr/share/nginx/html
# Exponemos el puerto 80
EXPOSE 80
# Arrancamos Nginx
CMD ["nginx", "-g", "daemon off;"]