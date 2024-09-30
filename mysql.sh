#!/bin/bash

echo"Developer has chosen the database MySQL. Hence, we are trying to install it up and configure it."

echo"Versions of the DB Software you will get context from the developer, Meaning we need to check with developer."

echo"Install MySQL Server 8.0.x"

echo"dnf install mysql-server -y

Start MySQL Service

systemctl enable mysqld

systemctl start mysqld
"