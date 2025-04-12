# Use an official Node.js LTS runtime as a parent image
# Choose a version compatible with your project (e.g., 18 or 20)
FROM node:22-alpine AS base

# Set the working directory in the container
WORKDIR /app

# Install system dependencies if needed (e.g., for node-gyp compilation)
# RUN apk add --no-cache python3 make g++

# Copy package.json and package-lock.json first for layer caching
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application code into the container
COPY . .

# Set environment variables needed by AdonisJS
ENV NODE_ENV=development
ENV HOST=0.0.0.0
ENV PORT=3333
# Add other non-sensitive defaults if desired

# Expose the port the app runs on (defined by PORT env var)
EXPOSE 3333
# Expose the Vite HMR port if different and used directly
EXPOSE 5173

# --- Development Stage ---
# For development, we'll run ace serve --watch
# The actual command will be overridden in docker-compose.yml for flexibility

# --- Production Stage (Optional - for building a production image later) ---
# FROM base AS production
# ENV NODE_ENV=production
# RUN node ace build --production
# RUN npm prune --production
# COPY --from=base /app/build /app/build
# CMD ["node", "build/server.js"]