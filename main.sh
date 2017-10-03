#!/bin/bash

. include/common.sh
. include/nginx.sh
. include/php.sh

if [ $(id -u) != "0" ]
then
 EchoRed "Error: You must be root to run this script, please use root to install"
 exit 1 
fi

echo "
                                                 
    _/        _/      _/  _/_/_/    _/      _/   
   _/        _/_/    _/  _/    _/  _/_/  _/_/    
  _/        _/  _/  _/  _/_/_/    _/  _/  _/     
 _/        _/    _/_/  _/        _/      _/      
_/_/_/_/  _/      _/  _/        _/      _/       
";

PrintSystemInfo

# 判断下载目录是否存在
path=`pwd`;
path=${path}"/src";
if [ ! -d "$path" ]; then
    mkdir "$path"
fi

# 下载软件包
cd ${path}
wget -c https://ftp.pcre.org/pub/pcre/pcre-8.00.tar.gz
wget -c http://www.zlib.net/zlib-1.2.11.tar.gz;
wget -c ftp://xmlsoft.org/libxml2/libxml2-2.9.4.tar.gz
wget -c http://nginx.org/download/nginx-1.13.5.tar.gz;
wget -c http://php.net/distributions/php-7.1.9.tar.gz;


#--------- 创建用户以及用户组 ---------
groupadd service_group -g 5000
useradd nginx -s /bin/bash -m -g 5000 -u 50001
useradd php -s /bin/bash -m -g 5000 -u 50002
useradd redis -s /bin/bash -m -g 5000 -u 5003
useradd mongodb -s /bin/bash -m -g 5000 -u 5004
EchoGreen "create service_group and nginx,php,redis,mongodb success"

#------ 定义版本信息 -------
phpVersion="php-7.1.9";
nginxVersion="1.13.5";
pcreVersion="8.00";
zlibVersion="1.2.11";
libxml2Version="2.9.4";

#--------- 安装依赖 ----------
apt-get install python-dev;
apt-get install openssl libssl-dev;
ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/lib/

EchoBlue "[+] Installing PCRE ${pcreVersion}...";
cd ${path}
tar -zvxf pcre-8.00.tar.gz
cd pcre-8.00
./configure
make
make install
EchoGreen "install pcre success!"


EchoBlue "[+] Install Zlib ${zlibVersion}..."
cd ${path}
tar -zvxf zlib-1.2.11.tar.gz
cd zlib-1.2.11;
./configure
make;
make install
EchoGreen "install zlib success"

EchoBlue "[+] Install libxml2 ${libxml2Version}..."
cd ${path}
tar -zvxf libxml2-2.9.4.tar.gz
cd libxml2-2.9.4;
./configure;
make;
make install;




EchoBlue "[+] Installing Nginx ${nginxVersion}...";
InstallNginx
EchoGreen "install nginx success"


EchoBlue "[+] Installing PHP ${phpVersion}";
InstallPhp;

InstallComposer;
# 拷贝php.ini配置文件
#phpIniPath=`php --ini | grep Path | awk '{print $5}'`;
#cd ${path}"php-7.1.9";
#cp php.ini-production phpIniPath"/php.ini";

EchoGreen "install php success";

EchoBlue "[+] Installing Mongodb"
su - mongodb <<EOF
    cd ~/;
    wget -c https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-3.4.9.tgz;
    tar -zvxf mongodb-linux-x86_64-ubuntu1604-3.4.9.tgz;
    exit;
EOF;