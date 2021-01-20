#!/usr/bin/env bash

# Button Apps to build
declare -a apps=( "Cmdr-One Here" "fman Here" "Links There" "Tab There" "Tab Here" )
declare -a wflows=( "Path Finder Root" )

make_release () {

	# compile any applescript scripts and add icon file
	for app in "${apps[@]}"; do
		echo "  make '${app}'"
		osacompile -o "${working_path}/${app}.app" "${app_src}/${app}/${app}.applescript"
		cp -f "${app_src}/${app}/${app}.icns" "${working_path}/${app}.app/Contents/Resources/applet.icns"
	done

	# unzip any workflow apps pre-built by automator
	for wflow in "${wflows[@]}"; do
		echo "  make '${wflow}'"
		unzip "${wflow_src}/${wflow}/${wflow}.zip" -d  "${working_path}" > /dev/null 2>&1
	done

}

make_debug () {
	echo "  running make on target ${target} in ${working_path}"
}

make_target () {

	# Do stuff common to all releases
	echo "  running make using makefile.sh on target ${target}"

	if [ $target == "release" ]; then
		# Do release stuff
		make_release

	elif [ $target == "debug" ]; then
		# Do debug stuff
		make_debug

	fi
}

