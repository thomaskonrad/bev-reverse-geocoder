FROM alpine:latest

RUN apk update
RUN apk add --no-cache \
    bash \
	git \
	python3 \
	python3-dev \
	gcc \
	linux-headers \
	pcre-dev \
	postgresql-dev \
	musl-dev \
	nginx \
	postgresql \
	postgresql-client \
	supervisor && \
	python3 -m ensurepip

# Edge testing packages
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    postgis

RUN pip3 install uwsgi requests pyproj==1.9.6

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/sites-available/default
COPY supervisor-app.conf /etc/supervisor/conf.d/

COPY requirements.txt /home/docker/code/app/
RUN pip3 install -r /home/docker/code/app/requirements.txt

COPY . /home/docker/code/

# Download and process the BEV address data
RUN cd /home/docker/code/scripts/convert-bev-address-data-python/ && \
    python3 convert-addresses.py -epsg 4326 -compatibility_mode

WORKDIR /home/docker/
EXPOSE 8080
CMD ["supervisord", "-n", "-c", "/home/docker/code/supervisor-app.conf"]
