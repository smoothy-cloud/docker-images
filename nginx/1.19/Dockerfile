FROM nginx:1.19

# add smoothy group
RUN groupadd --gid 1000 smoothy \
 && useradd smoothy --shell /bin/bash --uid 1000 --create-home --gid 1000 --groups tty

# install dependencies
RUN apt-get -y update \ 
 && apt-get -y install gosu \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add nginx configuration
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

# add entrypiont
COPY run.sh /run.sh
RUN mkdir -p /entrypoints \
 && chown smoothy:smoothy /entrypoints \
 && chmod g+s /entrypoints

RUN chown --recursive smoothy:smoothy /usr/share/nginx/html \
 && chmod g+s /usr/share/nginx/html \
 && chmod --recursive 775 /usr/share/nginx/html

EXPOSE 8080
WORKDIR /usr/share/nginx/html

CMD ["bash", "/run.sh"]