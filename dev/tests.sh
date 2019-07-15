#!/usr/bin/env bash

# Make sure the script was started like ./tests.sh (meaning the current directory is where the script is located)
[[ -e tests.sh ]] || { echo >&2 "Please cd into the script folder before running this script."; exit 1; }

if [ -z "$TMPDIR" ]; then
  echo "Warning: TMPVAR is empty - trying to use mktemp instead"
  TMPDIR=`mktemp -d`
  if [ -z "$TMPDIR" ]; then
    TMPDIR="/tmp"
  fi
fi
echo "Using temporary folder '$TMPDIR'"

# name of ramdisk volume
volume_name=phpbb
# size of ramdisk in MB
size=200

coverage_folder=$PWD/coverage/
extension_name=boardnotices
extension_path=phpBB/ext/fq/

sectors=$(( ${size} * 1024 * 1024 / 512 ))
mount_point=${TMPDIR}/${volume_name}

mkdir -p ${mount_point}

if [ "$(uname)" == "Darwin" ]; then
  # Creating, formatting and mounting a volume in RAM
  dev=$(hdiutil attach -nomount ram://${sectors})
  newfs_hfs -v "${volume_name}" ${dev}
  mount -t hfs -o nobrowse $dev "${mount_point}"
  echo "Mounted ${volume_name} (${size} MB) at ${mount_point}"
fi

echo "Copying phpBB into ramdisk..."
# Copying phpBB into ramdisk
rsync -a ../phpbb/phpBB ../phpbb/tests ${mount_point}/

# Copying boarbnotices into ramdisk
rsync -a ../${extension_name} ${mount_point}/${extension_path}

cd ${mount_point}
export XDEBUG_CONFIG="idekey=VSCODE"
php phpBB/vendor/bin/phpunit \
  --configuration ${extension_path}${extension_name}/phpunit.xml \
  --bootstrap tests/bootstrap.php \
  --testsuite "Extension Test Suite" \
  --coverage-html ${coverage_folder} \
  --log-junit ${coverage_folder}/phpunit.xml \
  --coverage-clover ${coverage_folder}/phpunit.coverage.xml

cd ..

if [ "$(uname)" == "Darwin" ]; then
  umount "${mount_point}"
  hdiutil detach ${dev}
else
  # Better clean up afterward...
  rm -rf ${mount_point}
fi

echo "Coverage is available at ${coverage_folder}index.html"
