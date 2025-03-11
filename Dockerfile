# Step 1: Build the React App
FROM node:18.13.0 AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project
COPY . .

# Build the React app (no need for --prod)
RUN npm run build

# Step 2: Serve with Nginx
FROM nginx:latest

# Copy build files to Nginx's serving directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
