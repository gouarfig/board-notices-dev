#!/usr/bin/env bash

# Make sure the script was started like ./tests_docker.sh (meaning the current directory is where the script is located)
[[ -e tests_docker.sh ]] || { echo >&2 "Please cd into the script folder before running this script."; exit 1; }

extension_name=boardnotices
extension_path=phpBB/ext/fq/

local_phpbb=$PWD/../phpbb/phpBB
local_phpbb_tests=$PWD/../phpbb/tests
local_extension=$PWD/../${extension_name}
local_coverage=$PWD/coverage/

docker_source=/src
docker_coverage=/coverage
docker_image=phpstorm/php-71-cli-xdebug

echo "Starting php from docker image ${docker_image}"
docker run -it --rm \
  -v ${local_phpbb}:${docker_source}/phpBB \
  -v ${local_phpbb_tests}:${docker_source}/tests \
  -v ${local_extension}:${docker_source}/${extension_path}${extension_name} \
  -v ${local_coverage}:${docker_coverage} \
  -w ${docker_source} \
  -e XDEBUG_CONFIG="idekey=VSCODE" \
  ${docker_image} \
  php phpBB/vendor/bin/phpunit \
  --configuration ${extension_path}${extension_name}/phpunit.xml \
  --bootstrap tests/bootstrap.php \
  --testsuite "Extension Test Suite" \
  --coverage-html ${docker_coverage} \
  --log-junit ${docker_coverage}/phpunit.xml \
  --coverage-clover ${docker_coverage}/phpunit.coverage.xml

echo "Coverage is available at ${local_coverage}index.html"
