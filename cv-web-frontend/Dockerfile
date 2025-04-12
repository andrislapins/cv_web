###
###
###

FROM node:22 as build

ENV APP_USER="app_user"
ENV APP_USER_HOME="/home/${APP_USER}"
ENV APP_HOME="/home/${APP_USER}/app"
ENV APP_GROUP="${APP_USER}_group"

RUN addgroup --system --gid 35001 $APP_GROUP && \
    adduser --system --ingroup $APP_GROUP -u 35001 --shell /bin/bash --home $APP_USER_HOME $APP_USER && \
    mkdir -p $APP_HOME && chown $APP_USER:$APP_GROUP $APP_HOME && \
    mkdir -p /build && \
    chown $APP_USER:$APP_GROUP -R /build && chmod 777 -R /build

COPY . /build
WORKDIR /build

RUN ls -al /build && npm install

RUN npm run build

###
###
###

FROM nginx:stable-alpine

ENV APP_USER="app_user"
ENV APP_USER_HOME="/home/${APP_USER}"
ENV APP_HOME="/home/${APP_USER}/app"
ENV APP_GROUP="${APP_USER}_group"

RUN apk add --no-cache shadow && \
    addgroup -g 35001 $APP_GROUP && \
    adduser -D -u 35001 -G $APP_GROUP -s /bin/bash -h $APP_USER_HOME $APP_USER && \
    mkdir -p $APP_HOME && chown 35001:35001 -R $APP_HOME

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d

COPY --from=build /build/dist /usr/share/nginx/html

RUN chown $APP_USER:$APP_GROUP /var/cache/nginx/ && \
    chown $APP_USER:$APP_GROUP /var/log/nginx && \
    chown $APP_USER:$APP_GROUP /etc/nginx/conf.d

RUN touch /var/run/nginx.pid && \
    chown -R $APP_USER:$APP_GROUP /var/run/nginx.pid

USER 35001

VOLUME /tmp

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 3000