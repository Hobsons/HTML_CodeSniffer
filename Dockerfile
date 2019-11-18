FROM node:10.15.3 as build-env
WORKDIR /app
COPY package*.json .npmrc* /app/
RUN npm ci && npm cache clean --force
COPY . /app
RUN npx grunt build

# Publish Environment
FROM r.cfcr.io/hobsons/jfrog_npm_wrapper:STABLE as publish-env
WORKDIR /plugin
# Copy the output of the build for the npm plugin to use
COPY --from=build-env /app /app
