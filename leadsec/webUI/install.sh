# written by tianye

prefixPath='/usr/local'

# dependant module
cp -rfn depLib/lib/*              $prefixPath/lib/
cp -rfn depLib/bin/*              $prefixPath/bin/
cp -rfn depLib/include depLib/ssl $prefixPath/

# nginx and php
cp -rfn webserver $prefixPath/

# add new user 'nobody', for nginx worker process
adduser nobody -DH

# create Smarty template dir
mkdir $prefixPath/webserver/nginx/html/Tpls/templates_c
mkdir $prefixPath/webserver/nginx/html/Tpls/cache
chown nobody:nobody $prefixPath/webserver/nginx/html/Tpls/templates_c
chmod 770 $prefixPath/webserver/nginx/html/Tpls/templates_c
chown nobody:nobody $prefixPath/webserver/nginx/html/Tpls/cache
chmod 770 $prefixPath/webserver/nginx/html/Tpls/cache

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
