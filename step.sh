#!/bin/bash
set -ex

if [ -z ${bitrise_dsym_dir_path+x} ] 
then
  echo "BITRISE_DSYM_DIR_PATH environment variable is not set, make sure you run this step after the xcode-archive step."
  exit 1
fi

if [ ! -e ${bitrise_app_dir_path}/${google_service_plist_file_name} ] 
then
  echo "Could not find ${google_service_plist_file_name} in the build, make sure it is being copied during your build phase."
  exit 1
fi

if [ ! -e ${fabric_upload_symbols_script_file} ] 
then
  echo "Could not find the fabric script file at ${fabric_upload_symbols_script_file}, please ensure the path is correct."
  exit 1
fi


echo "Searching for dSYM files in ${bitrise_dsym_dir_path} and uploading to ${bitrise_app_dir_path}/${google_service_plist_file_name} using script ${fabric_upload_symbols_script_file}"
find ${bitrise_dsym_dir_path} -name "*.dSYM" | xargs -I \{\} ${fabric_upload_symbols_script_file} -gsp ${bitrise_app_dir_path}/${google_service_plist_file_name} -p ios \{\}
