# Step 1: Build the React App
FROM node:18.13.0 AS build

WORKDIR /app

# Copy package.json and package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project
COPY . .

# Fix permission issues for Vite
RUN chmod +x node_modules/.bin/vite

# Run the build command with full path
RUN npx vite build

# Step 2: Serve the App with Nginx
FROM nginx:latest

# Copy built React app from the previous stage to Nginx's serving directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
