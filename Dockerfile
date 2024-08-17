
# Use an official Nginx image as a base
FROM nginx:1.26-alpine

# Copy the static files to the Nginx web directory
COPY . /usr/share/nginx/html

# Expose port 80 to allow external access
EXPOSE 80

# Start Nginx and keep it running in the foreground
CMD ["nginx", "-g", "daemon off;"]


