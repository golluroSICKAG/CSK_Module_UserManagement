# Changelog
All notable changes to this project will be documented in this file.

## Release 1.6.1

### Bugfix
- Updated legacy UI bindings

## Release 1.6.0

### New features
- Provide version of module via 'OnNewStatusModuleVersion'
- Function 'getParameters' to provide PersistentData parameters
- Check if features of module can be used on device and provide this via 'OnNewStatusModuleIsActive' event / 'getStatusModuleActive' function

### Improvements
- New UI design available (e.g. selectable via CSK_Module_PersistentData v4.1.0 or higher), see 'OnNewStatusCSKStyle'
- 'loadParameters' returns its success
- 'sendParameters' can control if sent data should be saved directly by CSK_Module_PersistentData
- Changed log level of some messages from 'info' to 'fine'
- Added UI icon and browser tab information

### Bugfix
- Legacy bindings of ValueDisplay within UI did not work if deployed with VS Code AppSpace SDK
- UI differs if deployed via Appstudio or VS Code AppSpace SDK
- Fullscreen icon of iFrame was visible

## Release 1.5.0

### Improvements
- "Wrong password" info in StackView to hide per default (before the message was shown for some ms)
- Using recursive helper functions to convert Container <-> Lua table
- Update to EmmyLua annotations
- Usage of lua diagnostics
- Documentation updates

## Release 1.4.0

### Improvements
- Using internal moduleName variable to be usable in merged apps instead of _APPNAME, as this did not work with PersistentData module in merged apps.

## Release 1.3.0

### New features
- Hide parameter setup if not logged in

### Improvements
- Loading only required APIs ('LuaLoadAllEngineAPI = false') -> less time for GC needed
- Update of helper funcs to support 4-dim tables for PersistentData
- Minor code edits / docu updates

## Release 1.2.0

### Improvements
- Changed status type of user levels from string to bool, so it is more consistent for other modules to handle the status (e.g. to disable UI elements)
- Renamed page folder accordingly to module name
- Updated documentation

## Release 1.1.0

### New features
- User "Admin" cannot be deleted

## Release 1.0.0
- Initial commit