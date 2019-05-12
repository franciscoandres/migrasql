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
	printf "\n\e[91mYou must provide a name\e[0m\n";
	exit 0;
fi

if [ ! -d "${FOLDERS_STRUCTURE}" ]; then
	mkdir -p "${FOLDERS_STRUCTURE}";
fi

touch "${SQL_MAIN_FOLDER_NAME}/${SQL_MIGRATE_FILE_NAME}.sql";

printf "\e[1mCreating migration file...\e[0m \e[2m%s/%s_$1.sql\e[0m\n" "${FOLDERS_STRUCTURE}" "${CURRENT_DATE}";
touch "${FOLDERS_STRUCTURE}/${CURRENT_DATE}_$1".sql;
printf "\e[92mDone!\e[0m\n";

if [ -e "${MIGRATE_FILE}" ]; then
	rm -f "${MIGRATE_FILE}";
fi

for sqlFile in "${FOLDERS_STRUCTURE}"/*.sql; do
	printf "%s" "--- Your SQL code here!" >> "${sqlFile}";
	printf "\ir %s/$(basename "${sqlFile}")%b\n" "${SQL_FILES_FOLDER_NAME}" >> "${MIGRATE_FILE}";
done
