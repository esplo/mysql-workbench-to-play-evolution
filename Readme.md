# MySQL Workbench to Play-Evolution for Initial Development

## What's this

This script converts an exported sql file by MySQL Workbench into Play-Evolution's migration files.

This replaces all the exsisting migration files, so we can use this only in an initial development phase.

## Usage

1. create a model with MySQL Workbench's EER Diaglam
1. export model as a sql script ("File" -> "Export" -> "Forward Engineer SQL Create Script...")
1. save it as a "schema.sql", and place it in this directory
1. run "$ ./split.sh 'target directory'"


