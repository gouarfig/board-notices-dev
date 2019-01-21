#!/bin/sh

cd ..
rsync -avz --exclude "*/.git/*" --delete boardnotices phpbb/phpBB/ext/fq/
epv/src/EPV.php run --dir="phpbb/phpBB/ext/fq/boardnotices/"
cd phpbb
phpBB/vendor/bin/phpunit \
  --configuration phpBB/ext/fq/boardnotices/phpunit.xml.dist \
  --bootstrap tests/bootstrap.php \
  --testsuite "Extension Test Suite" \
  $@

