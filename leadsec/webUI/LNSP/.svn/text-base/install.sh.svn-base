# written by tianye

prefixPath='/usr/local'

# dependant module
cp -rf lib/*      $prefixPath/lib/
cp -rf bin/*  	  $prefixPath/bin/
cp -rf include  $prefixPath/

# nginx and php
cp -rf ssl webserver $prefixPath/

# add new user 'nobody', for nginx worker process
adduser nobody -DH

# start nginx server
$prefixPath/webserver/nginx/sbin/nginx -c $prefixPath/webserver/nginx/conf/nginx.conf

# start php-fpm
$prefixPath/webserver/php/sbin/php-fpm start

# auto-start nginx+php on booting
echo -e "#start nginx+php
/usr/local/webserver/php/sbin/php-fpm start
/usr/local/webserver/nginx/sbin/nginx -c /usr/local/webserver/nginx/conf/nginx.conf
" >> /etc/rc.d/rc.local

echo 'Env Installation Complete.'
