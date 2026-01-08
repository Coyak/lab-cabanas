# Etapa 1: Construcción
FROM node:lts-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Servidor Web (Nginx)
FROM nginx:alpine
# Copiar la configuración por defecto de Astro (dist) al directorio de Nginx
COPY --from=build /app/dist /usr/share/nginx/html
# Copiar nuestra configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]