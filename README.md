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

Precision movement
- **moveCursor(Left/Right/Up/Down)**: Move cursor 1 pixel in any direction

Continous movement ([Keyboard Limitation]())
- **setContinousMouseControll**: Enable/disable all hotkeys under "Continous movement"
- **changeCursorSpeed(Up/Down)**: Change between cursor speed options  \
  For the speed options, see: `cursorMover_options` section > `cursorSpeedOptions`
- **moveCursorContinously(Left/Right/Up/Down)**: Move cursor in any direction with the defined speed  \
  For setting the speed, see:
    - `cursorMover` section > `changeCursorSpeed(Up/Down)`)
    - `cursorMover_options` section > `cursorSpeedOptions`
- **leftClick**: Alternative for MainMouseButton
- **rightClick**: Alternative for SecondaryMouseButton
- **middleClick**: Alternative for MiddleMouseButton
- **macro1**: Alternative for MouseForward
- **macro2**: Alternative for MouseBackward
- **scrollUp**: Alternative for scrolling up (2 of the smallest roll possible per press)
- **scrollDown**: Alternative for scrolling down (2 of the smallest roll possible per press)
- **doubleClick**: Simple double click
- **tripleClick**: Simple triple click

### Additional Settings

Configuration section `cursorMover_options`

- **cursorSpeedOptions**:  \
  *Description*: Cursor speed options that can be used for moving the cursor  \
  *Unit*: pixel / second (px/sec)  \
  *Format*: Comma separated list of integers  \
  *Default*: `50, 100, 250, 500, 1000, 2500, 5000, 10000`  \
  *Related Hotkeys*: For changing between speeds, see: `cursorMover` section > `changeCursorSpeed(Up/Down)`
- **initalSpeedOptionIndex**:  \
  *Description*: Index of the cursor speed option to start with  \
  *Default*: If `cursorSpeedOptions` is defined: `0`. Otherwise `2`  \
  *Related Hotkeys*: For setting the speed options, see: `cursorMover_options` section > `cursorSpeedOptions`)

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

## Keyboard Limitation

On most keyboards, not any combination of keys can be detected due to their design (see [stackExchange question](https://gaming.stackexchange.com/questions/6669/how-do-i-remove-the-limit-on-pc-keyboard-button-presses)).  \
This means that if you find that some remapped buttons are not working when used at the same time, it is most likely due to this limitation.

What you can do:
- Map your hotkeys in a different way
- Buy a better keyboard
- Accept not being able to use the script to it's full capability

## Key Namings

### MainMouseButton

**Left** button on right handed mouses  
**Right** button on left handed mouses

### SecondaryMouseButton

**Right** button on right handed mouses  
**Left** button on left handed mouses

### MiddleMouseButton

Clicking on the mouse wheel

### MouseForward

On better / gaming mouses there are usually 2 extra buttons at the thumb. This is usually the one closer to the user

### MouseBackward

On better / gaming mouses there are usually 2 extra buttons at the thumb. This is usually the one further from the user

# Responsibility

Only use or do anything at your own risk. I do not take responsibility for any damage which occours from using or following anything here in any way, shape or form

# Dependencies

If you wish to use / play around with the scripts instead of the built version, you need some dependencies  \
All of the dependencies can be found in the following repository: [HeckR_AUH-Lib](https://github.com/Heck-R/HeckR_AUH-Lib)

The dependencies should be placed anywhere where they can be imported using the angle bracket syntax (e.g.: `<modulname>`). One possibility is to put them directly inside a folder named `Lib` next to the main script (`HeckR_Hotkey.ahk`)

Some of these might be 3rd party scripts. The original authors and sources are linked in the repository provided above

- HeckerFunc

# Donate

I'm making tools like this in my free time, but since I don't have much of it, I can't give all of them the proper attention.

If you like this tool, you consider it useful or it made you life easier, please do not hesitate to thank/encourage me to continue working on it with any amount you see fit. (You know, buy me a cup of coffee / gallon of lemonade / 5-course gourmet dish / whatever you think I deserve 🙂)

<a href="https://www.paypal.com/paypalme/HeckR9000">
    <img 
        width="200px"
        src="https://gist.githubusercontent.com/Heck-R/20e9c45c2242467a028c107929187789/raw/cde2167d941416815d0e6f90638d85e2f289c988/donate.svg">
</a>
