# first phase - run dependencies and npm run build
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
# don't need volumes because we're done developing
# this is for production, we are not making changes
COPY . .
RUN npm run build

# we now have a build folder now in /app/build 
FROM nginx
# copy from previous phase, from given folder
# to new folder given in nginx documentation
# default command of nginx image is to start nginx
# so, do not need separate RUN command
COPY --from=0 /app/build /usr/share/nginx/html