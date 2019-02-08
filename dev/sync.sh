#!/bin/sh

cd ..
rsync -avz --delete --checksum boardnotices precisionos:~/Development/board-notices-dev/
