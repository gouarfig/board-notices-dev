#!/bin/sh

cd ..
rsync -avz --delete boardnotices phpbb/phpBB/ext/fq/
cd phpbb
phpBB/vendor/bin/phpunit --configuration phpBB/ext/fq/boardnotices/phpunit.xml.dist --bootstrap tests/bootstrap.php $@

