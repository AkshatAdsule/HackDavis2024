FROM node:20-alpine

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install

# set production mode for nestjs
ENV NODE_ENV production

# Expose port 3000
EXPOSE 3000

# Bundle app source
COPY . .

# add environment variables to the container
ARG DATABASE_URL
ENV DATABASE_URL $DATABASE_URL

# generate prisma client
RUN npx prisma generate

# Run the app
CMD [ "npm", "start" ]