# Path Finder Button Apps Collection (macOS)

## Overview

This project is a collection of button apps intended for use with the macOS application `Path Finder`. A button app in this context means a small helper app that adds extended functionality that is not part of the default Path Finder application. The apps are meant to be added to the Path Finder toolbar where they can be accessed during normal use.

## Installation & Setup

To use the apps, do the following:

1. Copy the apps to a dedicated permanent folder. A suitable location might be $HOME/Library/Scripts/Applications/Path Finder.
2. Add the included icons to the following apps. The easiest way to do this is to select the app, press `⌘ I` to open the file Info window, then drag-drop the icon onto the icon shown in the top left of the Info window:
   - Path Finder Root: Path Finder Root.icns
3. Open Path Finder and do the following:
   1. Right click on the Path Finder toolbar and select `Add Custom Items...` from the pop-up menu.
   2. From the `File Open` dialog that pops up, select one or more apps and click`Add`. The selected apps will be added to the end of the Path Finder toolbar.
   3. Right click on the Path Finder toolbar and select `Customize Toolbar...` from the pop-up menu.
   4. Move the apps to a suitable location on the toolbar.
   5. Assign Accesibility Permissions (required):
      -  Open Mac`System Preferences >> Security & Privacy`and select the `Privacy` tab.
      - Select `Accessibility` on the left side, then select the `+` button on the right.
      - In the `File Open` dialog that pops up, navigate to where you installed the button apps, select one or all of apps, and click Open to add them to the Accessibility list.
      - The apps now have the permissions necessary to function properly.

## Button Apps

The button apps that are included in this release are listed below.

|     Button App     | Function and Usage                                           |
| :----------------: | ------------------------------------------------------------ |
|     `Tab Here`     | In <u>single</u> or <u>dual</u> browser mode, opens a new tab in the <u>current</u> brower at either 1) the path of the current browser location or 2) the path of a selected folder in the current browser |
|    `Tab There`     | In <u>dual</u> browser mode, opens a new tab in the <u>opposite</u> browser at either 1) the path of the current browser location or 2) the path of a selected folder in the current browser |
|   `Links There`    | Creates symbolic links in the opposite browser for selections made in the current browser |
| `Path_Finder_Root` | Launches  a new Path Finder instance as superuser (root). Can be dangerous (see note below). |
|    `fman Here`     | Launches the file manager `fman`on the current browser path  |
|  `Cmdr-One Here`   | Launches the file manager `Commander-One`on the current browser path |

## Notes

- Warning: Using `Path Finder Root` can be dangerous unless you know what you are doing. Messing with system files is not conducive to your Mac's health. Changing or deleting system content can brick your computer so user beware.
- Future development: Check the project GiHub page occasionally for updates and new apps.

## GitHub

This project can be found on GitHub at [Path Finder_Button_Apps](https://github.com/mark-ingenosity/PathFinder_Button_Apps)

