random AHK scripts

they are messy 😛 

- - - - -

Windows only

if you want to use these and have no clue how:

### TrenchBroom
how to use
1. install https://www.autohotkey.com/
2. boot TrenchBroom.ahk

read the links below if you want to edit the hotkeys, but
as the script is right now, here's what they do
- mouse 4	... double left click
- numpad 3 ... shift click

**Makkon {techdc - write a word, and then optionally paste it**
- alt t	... paste	- large
- ctrl alt t ... no paste - large
- shift alt t	... paste	- small
- shift ctrl alt t ...	no paste - small

**Rename**
- F2 ... rename entity
- shift F2 ... rename path corner w/ number
  - type an integer after hitting the hotkey

**Everything else**
- F4 ... search bar
- alt C	... compile
  - as it is, you must set the compile menu hotkey to F12 in TrenchBroom
- alt L	... launch
  - type an integer (corresponding to the engine) after hitting the hotkey
  - as it is, you must set the launch menu hotkey to F11 in TrenchBroom
- alt 1	... launch first engine
- alt 2	... launch second engine
  - you can add more in the script trivially with something like `!3:: Launch(5)`
- alt 0	 ... open TrenchBroom preferences in Notepad++, falling back to Notepad
- win End	... exit script

https://www.autohotkey.com/docs  
https://www.autohotkey.com/docs/Hotkeys.htm  
https://www.autohotkey.com/docs/KeyList.htm  

also there are some hotkeys in here that i used for testing in-game skips  
they're commented within the script -- right now they're just grenade jumps and rocket jumps  
any actual debug commands are stored in my autoexec (see here for )
