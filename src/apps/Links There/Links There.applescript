# `Links There`, by Mark Vlach, October 2020
#
# Creates symbolic links in the opposite (destination) window pane for the
# selected items in the active window pane
#
#

(*
======================================
// USER SWITCHES
======================================
*)
# ENTER THE NAME OF THE FILE EXTENSION YOU WANT TO
# USE FOR THE CREATED SYMLINK. THIS CAN ALSO BE AN
# EMPTY STRING (e.g. "") FOR NO EXTENSION
property symlink_extension : ""

use AppleScript version "2.4" # Yosemite (10.10) or later
use scripting additions

# flag to control whether the script will continue
# to silently process items, skipping any existing
# symbolic links in the browser's opposite window
set continueAll to false

# get the path of the browser's opposite window
set destPath to getOppositeWindowPath()

tell application "Path Finder"
	# get the items selected in the current browser window
	set sel to (get selection)
	# quit if nothing is selected
	if (count of (selection)) = 0 then
		display dialog "No files or folders selected." buttons {"Continue�"} default button 1
		return 0
		# else, begin processing selected items
	else
		repeat with i from 1 to count sel
			try
				# get the posix path of the selected item
				set fpath to POSIX path of (item i of sel)
				# if an ending slash exists, strip it from the path
				if fpath ends with "/" then set fpath to rich text 1 thru -2 of fpath
				# extract the file/folder name from the item's path
				set fname to name of (item i of sel)
				# generate the posix path of the desired symbolic link to be
				# created in the opposite window
				set fsymlink to destPath & "/" & fname & symlink_extension
				# check if the symlink already exists in the opposite window.
				if my isSymLink(fsymlink) is false then
					# If it doesn't exist, then create it
					set output to do shell script "ln -s " & quoted form of fpath & " " & quoted form of fsymlink
				else
					# if Continue All has not already been set, warn the user that the symlink
					# already exists. Else if, Continue All has been set, keep procesing selected
					# items silently, skipping any existing symlinks.
					if continueAll is false then
						display dialog "File '" & fsymlink & "' already exists in destination." buttons {"Continue", "Continue All", "Quit"} default button "Continue"
						# if a symlink already exists and Continue All is not set,
						# give the user the option to Quit and abort the entire operation
						if result = {button returned:"Quit"} then
							return 0
						else if result = {button returned:"Continue All"} then
							# else set Continue All and begin silently processing the rest
							# of the selected items
							set continueAll to true
						end if
					end if
					# else, the user has pressed Continue so get the next items and continue
				end if
			on error errMsg number errorNumber
				# if there was an unexpected error, abort the operation and open a
				# dialog to display the error
				display dialog "Error: " & errMsg & " (" & errorNumber & ")" as rich text
				return errNumber
			end try
		end repeat
	end if
end tell

# handler to get the path of the opposite browser window.
# returns the path of the opposite window
on getOppositeWindowPath()
	activate application "Path Finder"
	tell application "System Events" to keystroke tab
	delay 0.5
	tell application "Path Finder"
		set destPath to the POSIX path of the target of the front finder window
	end tell
	tell application "System Events" to keystroke tab
	delay 0.5
	return destPath
end getOppositeWindowPath

# handler to check if the given path is a symbolic link.
# returns the status as true/false
on isSymLink(posixPath)
	try
		do shell script "[[ -L " & quoted form of posixPath & " ]]"
		return true
	end try
	return false
end isSymLink
