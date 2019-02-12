#!/bin/sh

cd ..
cd phpbb
export XDEBUG_CONFIG="idekey=VSCODE"
php phpBB/vendor/bin/phpunit \
  --configuration phpBB/ext/fq/boardnotices/phpunit-docker.xml \
  --bootstrap tests/bootstrap.php \
  --coverage-html coverage/
