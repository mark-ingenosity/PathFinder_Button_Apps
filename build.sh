#!/usr/bin/env bash

# Build parameters
project="Pathfinder-Button-Apps"
proj_type="applescript"
rel_path="build/release"
dbg_path="build/debug"
app_src="src/apps"
wflow_src="src/wflow"

# source helper resources
if [ ! -f build.inc ]; then echo "build.inc not found"; exit; fi
source build.inc

# Project content to be copied to build target
declare -a proj_content=( "doc" "resources/*" "example" "src/config/*" "src/scripts/*" )

# Punt if there are no arguments
if [ -z "$1" ]; then
	echo "Usage: build.sh <release | debug>"
	exit
else
	target=$1
fi

# Test for correct build command line option and set target path
if ! [[ $target == release || $target == debug ]]; then
	echo "aborting: unknown build target '${target}'"
	exit
fi
target_path="build/${target}"

# Clean
if [ -d "${target_path}" ]; then rm -rf "${target_path}"; fi

# make sure we have some source code to work with ;-)
if [ ! -d ${app_src} ] || [ ! "$(ls -A ${app_src})" ]; then
	echo "aborting: no source found for project."
	exit
fi

# Set the target path
echo "Building ${project} target ${target}"
mkdir -p $target_path

# Set the working path
# if the target is a zip archive then create a temp working dir
# to contain the target files for later compression, else set
# the working dir to the target dir
#if [[  ! -z "$2" && "$2" = "zip"  ]]; then
if [ ! -z "$2" ] && [ "$2" = "zip" ]; then
	working_path="${target_path}/~temp"
	mkdir -p "${working_path}"
	archive=true
else
	working_path="${target_path}"
	archive=false
fi

# Copy project content
for content in ${proj_content[@]}; do
	path=$(resolve_path "${content}")
	if ([[ -d "$path" ]] && [[ $(ls -A "$path") ]]) || [[ -f "$path" ]]; then
		cp -r "$path" "${working_path}/"
	fi
done

# Copy default docs
if [ -f README.md ]; then cp README.md "${target_path}/"; fi
if [ -f INSTALL.md ]; then cp INSTALL.md "${target_path}/"; fi

# make the target if required
if [ -f makefile ]; then
	make $target
elif [ -f makefile.sh ]; then
	source makefile.sh
	make_target
fi

# Create the target archive
if [ $archive == true ]; then
	echo -e "  creating target archive ${project}.zip"
	pushd "${working_path}" > /dev/null 2>&1
	zip -r -q "../${project}.zip" *
	popd  > /dev/null 2>&1
  # remove the temp files
	rm -rf "${working_path}"
fi

# Cleanup any old stuff in the target
#rsync --recursive --delete --ignore-existing --existing --prune-empty-dirs --verbose . "${target_path}/"

echo Done

