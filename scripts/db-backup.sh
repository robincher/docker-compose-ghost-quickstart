#!/bin/bash
echo "#########################################################################"
echo "## BACKUP GHOST BLOG - `date +%A` - `date +%Y-%m-%d_%Hh%Mm%Ss` ##########"
echo "#########################################################################"

DAY=$(date +%A)
FULLDATE=$(date -I)

echo "Creating Backup Folder..."
mkdir -p /root/backup/ghost

echo "Stopping Ghost Service..."
docker stop ghost

echo "Backing up Ghost Data Folder..."
tar -zcvf /root/backup/ghost/ghost-$FULLDATE.tar.gz -C /root/docker-compose-ghost-quickstart/ghost/dbdata

echo "Starting Ghost Service..."
docker start blog_ghost_1

echo "## END BACKUP GHOST BLOG - `date +%A` - `date +%Y-%m-%d_%Hh%Mm%Ss` ##########"
