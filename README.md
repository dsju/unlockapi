# TSC Unlock API
A library that allows modders to create achievements and lock them behind bosses & challenges. Also allows the locking of a tainted character behind the closet.

### Installation
To add this library to your mod, you must:

If using the [one file version](https://github.com/dsju/unlockapi/releases):
> 1) Extract unlockapi.lua to a folder in your mod.
> 2) Set the "modname" variable to the name of your mod (this is used for saving).
> 3) Include unlockapi. through your main.lua file by adding the following line:
`include([directory where script is placed].unlockapi)`

If using the GitHub repository:
> 1) Extract **all of the files** of the repository (excluding README.md) to a folder in your mod.
> 2) Update the "root" variable in core.lua to the path to the library's folder (i.e. "scripts/libraries/unlockapi").
> 3) Set the "modname" variable in core.lua to the name of your mod (this is used for saving).
> 4) Include core.lua through your main.lua file by adding the following line:
`include([unlockapi directory].core)`

Finally, edit your save manager:

```lua
--Do this right before you save data (in the same function)
YourSaveData.UnlockAPI = UnlockAPI.Library:GetSaveData("YourModName")

--Do this after you load data (in the same function)
UnlockAPI.Library:LoadSaveData(YourSaveData.UnlockAPI)
```

### Wiki
Further info about the library can be found in the [wiki](https://github.com/dsju/unlockapi/wiki).
