FROM drupal:8-apache

RUN	apt-get update && \
    apt-get install -y \
	curl \
	unzip \
	git \
	default-mysql-client


# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php && \
	mv composer.phar /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');"


ADD mysql-connect.sh /
RUN chmod +x /mysql-connect.sh


# Instalação node 10 e npm 6.4

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh > /tmp/install.sh && \
    export NVM_DIR="$HOME/.nvm" && \
    chmod +x /tmp/install.sh && \
    /tmp/install.sh && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
    nvm install 10 && \
    nvm use 10 && \
    npm install -g npm@v6.4
 
ENTRYPOINT ["/mysql-connect.sh"]
CMD ["apache2-foreground"]
