# HeckR_Hotkey

HeckR_Hotkey is a collection of a bunch of small features that I found generally useful, but not big, or major enough, to have their own script.

# Functionallity & Usage

In HeckR_Hotkey the hotkeys are separated into multiple groups based on their functionality, which mainly manifests itself in the configuration file for the generaly user.

In order for the functionalities to be used, a hotkey has to be assigned to them in the configuration file named `HeckR_Hotkey.ini`.  \
See [AutoHotkey - Hotkeys](https://www.autohotkey.com/docs/Hotkeys.htm) to find out how you can define the hotkey you want. (The releavant part is the left side of the `::`, as the functionality is automatically attached by HeckR_Hotkey)

There is an example of a configuration file named `HeckR_Hotkey_example.ini`, which contains the possible settings, and short explanation comments (the lines starting with a `#`)

## Auto Clicker

This group can produce mouse clicking

### Hotkeys

#### autoClicker

- **toggleAutoClicking**: Turn on/off rapid clicking
- **heldAutoClicking**: Rapid clicking while thr assigned key is being held down (this hotkey must only consist of one key without modifiers)

## Cursor Mover

This group can produce cursor movement

### Hotkeys

#### cursorMover

- **moveCursorLeft**: Move cursor 1 pixel left
- **moveCursorRight**: Move cursor 1 pixel right
- **moveCursorUp**: Move cursor 1 pixel up
- **moveCursorDown**: Move cursor 1 pixel down

## File Executer

This group can run files.  \
These files can be either executables, or any kind of file that has an associated program / app.

### File Definition Format

The executable / file has to be defined in a standard shortcut (/ command line) format. This essentially means that the file / executable has to be defined, and optionally some parameters.

Some examples:
- `C:\myAwesomeFolder\bestFileEver.txt` (Open a file in the default editor)
- `C:\WINDOWS\system32\notepad.exe` (Start a program. Inclusion of `.exe` is optional)
- `notepad` (Start a program with only its executable's name if it's included in the [Path](#Path). `.exe` could be included)
- `notepad C:\myAwesomeFolder\bestFileEver.txt` (Start a program with a parameter)
- `notepad "C:\myAwesomeFolder\best file ever.txt"` (Use parameters containing spaces)
- `cmd /k "echo My awesome command"` (Run commands with a command line interface)
- `explorer %userprofile%` (Use built-in / environment variables)

### Hotkeys

#### fileRunner

A custom number of hotkeys can be created, by defining them in the format explained at [File Definition Format](#File-Definition-Format), and assigning a hotkey to them


### Additional Settings

Configuration section `fileRunner_startupCommands`

A list of executables / files can be defined in the format explained at [File Definition Format](#File-Definition-Format)  \
All of these will be run on the script's startup

## Helper Tooltip Controller

This group is about showing helpful tooltips

### Hotkeys

#### helperTooltipController

- **toggleHelperTooltip**: Turn on/off tooltip showing the hotkeys set in the script's ini file

## Script Flow Controller

This group can set the states of groups of AutoHotkey scripts  \
Scripts defined at the `scriptFlowController_mainScripts` section are called **main scripts**

### Hotkeys

#### scriptFlowController

Run
- **runAnyScriptWindow**: List and possibly run scripts from under _runnableScriptsRoot_ (see `scriptFlowController_options` section).  \
  Finds scripts on the following formatted paths:
  - `<categoryFolder>\scriptName.ahk`
  - `<categoryFolder>\scriptName\scriptName.ahk`

Reload
- **reloadAllScripts**: Reload all scripts
- **reloadMainScripts**: Reload main scripts
- **reloadTemporaryScripts**: Reload not main scripts

Suspend
- **suspendAllScripts**: Suspend all scripts
- **suspendMainScripts**: Suspend main scripts
- **suspendTemporaryScripts**: Suspend not main scripts

Exit
- **exitAllScripts**: Exit all scripts
- **exitMainScripts**: Exit main scripts
- **exitTemporaryScripts**: Exit not main scripts

#### scriptFlowController_options

- **runnableScriptsRoot**: Root folder to search for runnable scripts (see _runAnyScriptWindow_ at the `scriptFlowController` section).  \
  A relative path can be defined by starting with `.\`

#### scriptFlowController_mainScripts

The list of main scripts (see `scriptFlowController` section)

## Simple Action Remapper

This group can create alternative keybindings / hotkeys for some simple actions

### Hotkeys

#### simpleActionRemapper

- **copyContent**: Alternative for `ctrl+c`
- **pasteContent**:  Alternative for `ctrl+v`
- **deleteContent**:  Alternative for `del`

## Volume Controller

This group can change the settings of the default sound device

### Hotkeys

#### volumeController

- **increaseVolume**: Increase the default sound device's volume by 5%
- **decreaseVolume**: Decrease the default sound device's volume by 5%
- **muteVolume**: Mute the default sound device's volume
- **toggleVolumeTooltip**: Turn on/off tooltip feedback about volumeController actions

## Uncategorized

This group is a collection of other functionalities that could not be grouped

### Hotkeys

#### uncategorized

- **soundBeep**: A 1 second beep sound to wake up speakers
- **setWindowOnTop**: Enable/disable having the active window always on top of everything
- **setKeyPressCapturing**: After triggring, press any key / mouse button for having it held down. To release a held down key, just press and release it. Multiple things can be held down at the same time

# Notes

## Path

_Path_ is one of Windows' environment variables, that helps access files / executables easier

# Responsibility

Only use or do anything at your own risk. I do not take responsibility for any damage which occours from using or following anything here in any way, shape or form

# Dependencies

If you wish to use / play around with the scripts instead of the built version, you need some dependencies  \
All of the dependencies can be found in the following repository: [HeckR_AUH-Lib](https://github.com/Heck-R/HeckR_AUH-Lib)

The dependencies should be placed anywhere where they can be imported using the angle bracket syntax (e.g.: `<modulname>`). One possibility is to put them directly inside a folder named `Lib` next to the main script (`HeckR_Hotkey.ahk`)

Some of these might be 3rd party scripts. The original authors and sources are linked in the repository provided above

- HeckerFunc