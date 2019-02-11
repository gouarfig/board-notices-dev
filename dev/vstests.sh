#!/bin/sh

cd ..
rsync -avz --exclude "*/.git/*" --exclude "*/coverage/*" --delete boardnotices phpbb/phpBB/ext/fq/
cd phpbb
echo Starting phpunit from
pwd
export XDEBUG_CONFIG="idekey=VSCODE"
php phpBB/vendor/bin/phpunit \
  --configuration phpBB/ext/fq/boardnotices/phpunit.xml \
  --bootstrap tests/bootstrap.php \
  --debug --verbose \
  $@

