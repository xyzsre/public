# Use an official lightweight Node.js image
FROM node:14-alpine

# Set the working directory to /app
WORKDIR /app

# Copy index.html file into the container at /app
COPY index.html /app

# Expose port 80 to the outside world
EXPOSE 80

# Define environment variable
ENV NAME=World

# Run a simple HTTP server to serve the HTML file
CMD ["npx", "http-server", "-p", "80"]
