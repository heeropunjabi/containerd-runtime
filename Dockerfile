FROM node:18-alpine3.15 AS BUILD_IMAGE

# Add dependencies
RUN apk add curl bash --no-cache

# Install node-prune
RUN curl -sfL https://gobinaries.com/tj/node-prune | bash -s -- -b /usr/local/bin

# Create app directory
WORKDIR /app


COPY package.json yarn.lock ./

# install dependencies
RUN yarn --frozen-lockfile

COPY . .

# test
#RUN yarn test

# Run cleanup necessary dependencies 
RUN npm prune --production && npm cache clean --force

# run node prune
RUN /usr/local/bin/node-prune

FROM node:18-alpine3.15

WORKDIR /app

COPY --from=BUILD_IMAGE /app .

EXPOSE 3000

ARG GIT_COMMIT
ENV GIT_COMMIT=$GIT_COMMIT

ARG BRANCH_NAME
ENV BRANCH_NAME=$BRANCH_NAME

CMD ["yarn", "start"]