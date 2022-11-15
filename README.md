random AHK scripts

they are messy 😛

---

Windows only

if you want to use these and have no clue how:

### TrenchBroom

how to use

1. install https://www.autohotkey.com/
2. on this page, click 'Code' then 'Download ZIP'
3. boot TrenchBroom.ahk while TrenchBroom is open
4. edit keyboard shortcuts in Trenchbroom preferences ( View -> Preferences -> Keyboard )
   - Run > Launch Engine... to F11
   - Run > Compile Map... to F12
   - or edit the .ahk script to match

read the links below if you want to edit the hotkeys.
as the script is right now, here's what they do

| Key      | Action            |
| -------- | ----------------- |
| mouse 4  | double left click |
| numpad 3 | shift click       |

**Makkon {techdc - write words, and then optionally paste**

|                  |                  |
| ---------------- | ---------------- |
| alt t            | paste - large    |
| ctrl alt t       | no paste - large |
| shift alt t      | paste - small    |
| shift ctrl alt t | no paste - small |

**Rename, and path_corner stuff**

|              |                                                         |
| ------------ | ------------------------------------------------------- |
| F2           | rename highlighted/selected value                |
| shift F2     | for path_corners; press a number after this! renames selected entity value |
| ctrl shift P | create example/template path_corner                     |
| alt P        | iterate/create next path_corner                         |
| alt shift P  | same as above, but loop to path_corner 0                |

**whatever else**

|         |                                                                    |                                                                               |
| ------- | ------------------------------------------------------------------ | ----------------------------------------------------------------------------- |
| F4      | search bar                                                         |                                                                               |
| alt C   | compile (set to F12 in TrenchBroom)                                |                                                                               |
| alt L   | launch (set to F11 in TrenchBroom)                                 | type an integer (corresponding to the engine order) after hitting the hotkey  |
| alt 1   | launch first engine                                                |                                                                               |
| alt 2   | launch second engine                                               | you can add more in the script trivially with something like `!3:: Launch(5)` |
| alt 0   | open TrenchBroom preferences in Notepad++, falling back to Notepad |
| win End | exit script                                                        |

https://www.autohotkey.com/docs  
https://www.autohotkey.com/docs/Hotkeys.htm  
https://www.autohotkey.com/docs/KeyList.htm

also there are some hotkeys in here that i used for testing in-game skips
they're commented within the script -- right now they're just grenade jumps and rocket jumps
