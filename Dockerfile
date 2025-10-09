# Use official Nginx image as base
FROM nginx:latest

# Remove default Nginx page and copy your own
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 (default for Nginx)
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
