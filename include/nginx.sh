#!/bin/bash

InstallNginx(){
	
	tar -zvxf nginx-1.13.5.tar.gz;
	cd nginx-1.13.5;


	./configure --user=nginx --group=service_group --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module
	make;
	sudo make install;
}
