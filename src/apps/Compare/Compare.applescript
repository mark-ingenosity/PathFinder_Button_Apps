# `Compare`, by Mark Vlach, February 2021
#
# Runs diff tool on selections made in the same browser rather than the
# native comparison command which requires that two items be selected
# in two opposite browsers. Reduces diff operation steps by 2x.
#
use AppleScript version "2.4" # Yosemite (10.10) or later
use scripting additions

# get the file comparison tool defined in the Path Finder plist file
# the path to the tool is stored in the string key kNTDiffToolPath
# the plist file is located in ~/Library/Preferences/com.cocoatech.PathFinder.plist
#
set comptool to ""
tell application "System Events"
	set plist to (the POSIX path of (path to home folder)) & "/Library/Preferences/com.cocoatech.PathFinder.plist"
	tell property list file plist
		# get the comparison tool location stored in the key string value kNTDiffToolPath
		set comptool to the value of property list item "kNTDiffToolPath"
	end tell
end tell

# get the file selections and run the comparison. Only two files may be
# selected so abort with an error dialog if that requirement is not met.
#
tell application "Path Finder"
	# get the items selected in the current browser window
	set sel to (get selection)
	# only two items must be selected. quit if this requirement is not met
	if (count of (selection)) is not equal to 2 then
		display dialog "Please select only two items for comparison." buttons {"Cancel"} default button 1
		return 0
		# else, run the comparison on the two selected items
	else
		try
			# get the posix path of the selected items
			set fsel1 to POSIX path of (item 1 of sel)
			set fsel2 to POSIX path of (item 2 of sel)
			# run the comparison using the defined application comptool
			do shell script quoted form of comptool & " " & quoted form of fsel1 & " " & quoted form of fsel2
		on error errMsg number errorNumber
			if errorNumber < 0 then
				# if there was an unexpected error, abort the operation and open a
				# dialog to display the error
				display dialog "Error: " & errMsg & " (" & errorNumber & ") " as rich text
				return errorNumber
			end if
		end try
	end if
end tell
