# OS
FROM liting68/php7.2-fpm-alpine

# phalcon version
ENV PHALCON_VERSION=3.4.2

# install escentials
RUN apk update && apk add --no-cache \
	# compiler & tools
	bash \
	curl \
	make \
	g++ \
	autoconf \
	file \
	re2c \
	pcre-dev \
	# iconv & gd
	php7-iconv \
	php7-gd \
	php7-pdo \
	php7-pdo_mysql \
	php7-dev \
	php7-pear \
	php7-mysqli \
	php7-mbstring \
	php7-curl \
	php7-json \
	&& \
	# phalcon php
	cd /home \
	set -xe && \
	curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
	tar xzf v${PHALCON_VERSION}.tar.gz && \
	# compile
	cd cphalcon-${PHALCON_VERSION}/build && ./install && \
	echo "extension=phalcon.so" | tee -a /etc/php7/conf.d/20_phalcon.ini && \
	cd ../.. && rm -rf v${PHALCON_VERSION}.tar.gz cphalcon-${PHALCON_VERSION} \
	&& \
	# clean dev libs
	apk del \
	bash \
	curl \
	make \
	g++ \
	autoconf \
	file \
	re2c \
	pcre-dev \
	php7-dev \
	php7-pear \
	&& rm -rf /var/cache/apk/*