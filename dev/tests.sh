#!/usr/bin/env bash

# name of ramdisk volume
volume_name=phpbb
# size of ramdisk in MB
size=200

extension_name=boardnotices
extension_path=phpBB/ext/fq/

sectors=$(( ${size} * 1024 * 1024 / 512 ))
mount_point=./${volume_name}

# Creating, formatting and mounting a volume in RAM
mkdir -p ${mount_point}
dev=$(hdiutil attach -nomount ram://${sectors})
newfs_hfs -v "${volume_name}" ${dev}
mount -t hfs -o nobrowse $dev "${mount_point}"
echo "Mounted ${volume_name} (${size} MB) at ${mount_point}"

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
  --coverage-html ../coverage/

cd ..
umount "${mount_point}"
hdiutil detach ${dev}
