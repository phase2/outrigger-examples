# --- Dependencies ---
FROM outrigger/node:8 AS dependencies

# Set the working directory.
WORKDIR /code

# Set up file permissions and shared cache directories.
RUN mkdir -p /usr/local/share/.cache && \
    chown -R node:node /code && \
    chown -R node:node /usr/local/share/.cache

# Only perform the yarn install if package.json or the lockfile changes.
# Wildcards ensure all relevant files are included and that optional
# files that can modify the process are optional.
COPY ./package*.json ./.yarnrc ./yarn* ./

# Install dependencies and wipe the cache.
# --prefer-offline will seek dependencies from the offline mirror, which will
# need to be committed in development, not as part of a docker image build.
RUN yarn install --prefer-offline && yarn cache clean

# For npm, remove the above COPY and RUN steps and instead use:
# COPY ./package.json ./package* ./npm* ./.npm* /code/
# @TODO switch to npm ci when the official node image ships npm >= v5.7.1 and
# outrigger/node:8 is updated.
# RUN npm install

# --- Custom Code Build ---
FROM dependencies AS build

# Set the working directory.
WORKDIR /code

# Now copy the rest of the codebase.
# node_modules will be excluded by .dockerignore
COPY . /code

# If we have further build steps such as web asset management, insert that here.
# ENV NODE_ENV=production
# COPY --from=dependencies /code/node_modules /code
# RUN yarn run build && rm -Rf node_modules && rm -Rf .yarn-offline-mirror

# Strip the development dependencies now that build is complete.
RUN yarn install --ignore-scripts --offline && \
    yarn cache clean && \
    rm -Rf ./.yarn-offline-mirror
# If using npm, instead run the following:
# RUN npm prune

# Explicitly setting the user to root is necessary to modify permissions on /code.
# We arrange ownership by node in this intermediate container so it copies into
# the release image as a single layer.
USER root
RUN chown -R node:node /code

# --- Final Release ---
FROM outrigger/node:8 AS release

# @see http://label-schema.org/rc1/
LABEL maintainer="Phase2 <outrigger@phase2technology.com>" \
  # Replacement for the old MAINTAINER directive has fragmented.
  name="Project Name" \
  org.label-schema.name="Project Name" \
  org.label-schema.description="Outrigger-based Node service example." \
  org.label-schema.vcs-url="https://github.com/phase2/outrigger-example" \
  org.label-schema.docker.cmd="docker run --rm -it yourorg/projectname /bin/bash" \
  org.label-schema.schema-version="1.0"

# Build with NODE_ENV=development to include dev dependencies.
ENV NODE_ENV=production \
    # These are injected by runtime. The Docker image carries good defaults.
    APP_HOST=app.projectname.vm \
    APP_PORT=3773

# Set the working directory.
WORKDIR /code

# Expose our service port. This should be updated to match the configured port.
EXPOSE 3773

# Retrieve all assets from earlier build stages.
COPY --from=build /code .
# By copying from dependencies instead of build, we gain the yarn-offline-mirror
# copied into place and updated by the yarn install during the build.
# Delete this next line if not using Yarn.
COPY --from=dependencies /code/.yarn-offline-mirror .yarn-offline-mirror

# Re-run the yarn install, if in production mode this will exclude devDependencies.
# The offline flag means the complete status of the offline mirror is required.
RUN mkdir -p /usr/local/share/.cache && \
    chown -R node:node /usr/local/share/.cache

# Set a non-root user. This user is created upstream but not set for use.
USER node

# The start command should match the configured start script in package.json.
# By directly calling node here, the number of processes running inside the
# container is reduced and our service will directly receive process signals.
#
# To use the image another way run the container with an explicit command.
CMD ["node", "./index.js"]
