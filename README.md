# TSC Unlock API
A library that allows modders to create achievements and lock them behind bosses & challenges. Also allows the locking of a tainted character behind the closet.

### Installation

To add this library to your mod, you must:
1) Extract **all of the files** of the repository (excluding README.md) to a folder in your mod.
2) Update the "root" variable in core.lua to the path to the library's folder (i.e. "scripts/libraries/unlockapi").
3) Set the "modname" variable in core.lua to the name of your mod (this is used for saving).
4) Include core.lua through your main.lua file by adding the following line:

`include([unlockapi directory].core)`

5) Add these functions to your save manager before and after saving respectively to save the data of your characters/challenges:

`[savedata].UnlockAPI = UnlockAPI.Library:GetSaveData([your mod name])`
`UnlockAPI.Library:LoadSaveData([savedata].UnlockAPI)`

### Wiki
Further info about the library can be found in the [wiki](https://github.com/dsju/unlockapi/wiki).
