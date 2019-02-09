#!/bin/sh

cd ..
rsync -avz --exclude "*/.git/*" --exclude "*/coverage/*" --delete boardnotices phpbb/phpBB/ext/fq/
cd phpbb
echo Starting phpunit from
pwd
php -c /etc/php.ini.default phpBB/vendor/bin/phpunit \
  --configuration phpBB/ext/fq/boardnotices/phpunit.xml \
  --bootstrap tests/bootstrap.php \
  --debug --verbose \
  $@

