FROM php:7.2.9-zts
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get update && apt-get install -y git libpng-dev zlib1g-dev zip vim
#RUN pecl install grpc
RUN pecl install grpc && docker-php-ext-enable grpc
RUN git clone https://github.com/krakjoe/pthreads.git
RUN cd pthreads && phpize && ./configure && make && make install && docker-php-ext-enable pthreads
RUN apt-get install -y cmake
RUN git clone https://github.com/HdrHistogram/HdrHistogram_c
RUN cd HdrHistogram_c && cmake . && make && make install
RUN git clone https://github.com/beberlei/hdrhistogram-php.git
RUN cd hdrhistogram-php && phpize && ./configure && make && make install && docker-php-ext-enable hdrhistogram
RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN pecl install protobuf && docker-php-ext-enable protobuf
RUN docker-php-ext-install pcntl shmop
RUN apt-get install -y build-essential golang-go
RUN mkdir -p /var/www
VOLUME /var/www/
WORKDIR /var/www/
RUN apt-get install nano