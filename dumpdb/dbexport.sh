#!/bin/bash
ssh -i ssh/key.pem -o StrictHostKeyChecking=no ${SSH_USER_HOST} -x "mysqldump -u ${DB_REMOTE_USER} -p${DB_REMOTE_PASS} ${DB_REMOTE} > ~/file.sql"
scp -i ssh/key.pem ${SSH_USER_HOST}:~/file.sql /dumpdb/file.sql