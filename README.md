# phalcon-php7-alpine
Dockerfile
## How to use this file
```
docker build -t phalcon-php7 .
```
#### Create container
```
docker run -dit --name phalcon-php7 -p 8084:80 -v D:\wwwroot\:/var/www phalcon-php7 /sbin/init
```
#### Entering the container
```
docker exec -it phalcon-php7 sh
```
#### Edit nginx phalcon config file
```
vi /etc/nginx/conf.d/default.conf
```
#### Add server
```
server {
        listen          80;
        server_name     localhost;
        set $root_path '/var/www/public';
        index       index.php index.html index.htm;
        charset     utf-8;
        root    $root_path;

        try_files $uri $uri/ @rewrite;

        location @rewrite {
            rewrite ^/(.*)$ /index.php?_url=/$1;
        }

        location ~ \.php$ {
                fastcgi_pass 127.0.0.1:9000;

                fastcgi_index   index.php;

                fastcgi_split_path_info         ^(.+\.php)(/.+)$;
                fastcgi_param PATH_INFO       $fastcgi_path_info;
                fastcgi_param SCRIPT_TRANSLATED $document_root$fastcgi_path_info;
                fastcgi_param SCRIPT_FILENAME   $document_root$fastcgi_script_name;
                include fastcgi_params;
                fastcgi_buffers         256 16k;
        }

        location ~ /\.ht {
            deny all;
        }
}
```
#### Rester web server
```
service nginx restart
```
