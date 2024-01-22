#Stage 1: Build Node.js app
FROM node:latest AS builder

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install
RUN npm run build

# Copy the rest of the application code
COPY . .

# Build the application
#RUN npm run build

# Stage 2: Use Nginx base image for production
FROM nginx:latest

# Copy the built app from the previous stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Command to start Nginx and keep it running in the foreground
CMD ["nginx", "-g", "daemon off;"]

