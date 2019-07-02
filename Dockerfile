FROM alpine:latest

RUN apk update
RUN apk add bash \
	git \
	python3 \
	python3-dev \
	gcc \
	linux-headers \
	pcre-dev \
	postgresql-dev \
	musl-dev \
	nginx \
	supervisor && \
	python3 -m ensurepip

RUN pip3 install uwsgi

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/sites-available/default
COPY supervisor-app.conf /etc/supervisor/conf.d/

COPY requirements.txt /home/docker/code/app/
RUN pip3 install -r /home/docker/code/app/requirements.txt

COPY . /home/docker/code/

WORKDIR /home/docker/
EXPOSE 8080
CMD ["supervisord", "-n", "-c", "/home/docker/code/supervisor-app.conf"]
