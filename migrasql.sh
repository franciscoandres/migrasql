#!/usr/bin/env bash

set -o errexit;
set -o nounset;
# set -o xtrace;

readonly SQL_MAIN_FOLDER_NAME="main";
readonly SQL_FILES_FOLDER_NAME="files";
readonly SQL_MIGRATE_FILE_NAME="migrate";
readonly FOLDERS_STRUCTURE="${SQL_MAIN_FOLDER_NAME}/${SQL_FILES_FOLDER_NAME}";
readonly MIGRATE_FILE="${SQL_MAIN_FOLDER_NAME}/${SQL_MIGRATE_FILE_NAME}.sql";
readonly CURRENT_DATE=$(date +%Y%m%d%H%M%S);

if [ -z "$1" ]; then
	echo -e "\n\e[91mYou must provide a name\e[0m\n";
	exit 0;
fi

if [ ! -d "${FOLDERS_STRUCTURE}" ]; then
	mkdir -p "${FOLDERS_STRUCTURE}";
	touch "${SQL_MAIN_FOLDER_NAME}/${SQL_MIGRATE_FILE_NAME}.sql";
fi

echo -e "\e[1mCreating migration file...\e[0m \e[2m${FOLDERS_STRUCTURE}/${CURRENT_DATE}_$1.sql\e[0m"
touch "${FOLDERS_STRUCTURE}/${CURRENT_DATE}_$1".sql;
echo -e "\e[92mDone!\e[0m";

# I think will be better check if file exists in migrate.sql and if not just add it
if [ -e "${MIGRATE_FILE}" ]; then
	rm -f "${MIGRATE_FILE}";
fi

for file in "${FOLDERS_STRUCTURE}"/*.sql; do
	echo "\ir ${SQL_FILES_FOLDER_NAME}/$(basename "$file")" >> "${MIGRATE_FILE}";
done
