#!/bin/bash

InstallComposer() {
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
}

Ln_PHP_Bin()
{
    ln -sf /usr/local/php/bin/php /usr/bin/php;
    ln -sf /usr/local/php/bin/phpize /usr/bin/phpize;
    ln -sf /usr/local/php/bin/pear /usr/bin/pear;
    ln -sf /usr/local/php/bin/pecl /usr/bin/pecl;
    ln -sf /usr/local/php/sbin/php-fpm /usr/bin/php-fpm;
}

InstallPhp(){
	cd ${path}
	tar -zvxf php-7.1.9.tar.gz;
	cd php-7.1.9;

	./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-openssl --with-zlib;

	make;
	make install;

	cp php.ini-production /usr/local/php/etc/php.ini;

	Ln_PHP_Bin
}


