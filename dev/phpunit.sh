#!/bin/sh

PARAMETERS=$@
echo "Parameters sent: ${PARAMETERS}"

php -i | grep "xdebug.remote"

export XDEBUG_CONFIG="idekey=VSCODE"
php phpBB/vendor/bin/phpunit \
  --configuration phpBB/ext/fq/boardnotices/phpunit-docker.xml \
  --bootstrap tests/bootstrap.php \
  ${PARAMETERS}

