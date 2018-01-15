#!/usr/bin/env bash
#####################################################################
# Title    :nginx server dso configure script.
# Overview :install nginx dso provisoning.
#####################################################################
# Global variable definition area.
#####################################################################
# default.conf configure.
DEFAULT_CONFIG='/etc/nginx/conf.d/default.conf'

#####################################################################
# Function definition area.
#####################################################################

#####################################################################
# Main process definition area.
#####################################################################
# generate default.conf 
cat << 'EOF' > ${DEFAULT_CONFIG}
server {

    # Server baseic dedionition.
    listen               80 default_server;
    server_name          localhost;
    server_tokens        off;
    charset              UTF-8;
    client_max_body_size 32m;
    
    # HTTP Header definition.
    add_header Strict-Transport-Security max-age=15768000;
    real_ip_header X-Forwarded-For;

    # Document root definition.
    root    /home/webmaster/www/html;

    # Strict https request definition.
    if ($http_x_forwarded_proto != https) {
        return 301 https://$host$request_uri;
    }

    # Error page definition.
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # Location for helthcheck.
    location /index.html {
        satisfy any;
        allow   all;
    }

    # Pass request containing subdomain to PHP.
    location / {
        try_files $uri /index.php?$query_string;
    }

    # Send the request to PHP-FPM.
    location ~ \.php$ {
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root/$fastcgi_script_name;
        include        fastcgi_params;
    }

    ## Basic authentication definition area.
    #auth_basic           "auth";
    #auth_basic_user_file /home/webmaster/www/html/conf/htpasswd.conf;

}
EOF
cat ${DEFAULT_CONFIG}

# basic auth password files.
install -o nginx -g nginx -m 705 -d /home/webmaster/www/html/conf
cd /home/webmaster/www/html/conf
htpasswd -cdb htpasswd.conf 'ssmuser' '8DzVYxW4pn9p'
htpasswd -db htpasswd.conf 'Ho!sysUser' 'BVJH.X8XrSmv'
chown -R nginx:nginx /home/webmaster/www/html
cat htpasswd.conf

