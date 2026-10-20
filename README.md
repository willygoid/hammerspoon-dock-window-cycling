# Hammerspoon Dock Window Cycling

Cycle through an application's windows by clicking its active Dock icon on macOS, powered by [Hammerspoon](https://www.hammerspoon.org/).

## Overview

On macOS, clicking an application's Dock icon usually activates that application. This configuration adds a small behavior enhancement:

- **App is inactive:** Clicking its Dock icon activates it normally.
- **App is already active:** Clicking its Dock icon switches to another window belonging to that application.
- **Multiple windows:** Repeated clicks cycle through the application's available, non-minimized windows.

The goal is to make window switching feel more direct while keeping the familiar macOS Dock workflow.

## Requirements

- macOS
- [Hammerspoon](https://www.hammerspoon.org/) installed
- Accessibility permissions granted to Hammerspoon

## Installation

1. Install and launch Hammerspoon.
2. Open the Hammerspoon configuration file by selecting **Hammerspoon → Open Config**.
3. Back up your existing `init.lua`.
4. Add the Dock window cycling configuration to `~/.hammerspoon/init.lua`.
5. Save the file.
6. Select **Hammerspoon → Reload Config**.

If Hammerspoon cannot detect Dock items or control windows, check its permissions under **System Settings → Privacy & Security → Accessibility**.

## Usage

1. Open an application with multiple windows.
2. Click its Dock icon to activate it.
3. Click the same Dock icon again to switch to another window.
4. Continue clicking to cycle through the available windows.

When switching back to an inactive application, macOS handles the initial activation as usual.

## How It Works

The configuration uses Hammerspoon's Lua APIs to:

- Detect mouse clicks on Dock items.
- Identify the clicked application.
- Check whether that application is currently active.
- Retrieve its non-minimized windows.
- Focus the next window after a short delay.

It is intended to work across applications rather than being hard-coded for a single browser.

## Limitations

- Window order follows the list returned by Hammerspoon; it is not guaranteed to match the most recently used window order.
- Minimized windows are excluded from cycling.
- Applications with unusual window-management behavior may behave differently.
- macOS and Stage Manager may affect how individual windows are presented.
- This configuration does not replace or modify native macOS window-management features.

## Customization

The behavior can be customized in `init.lua`, including the delay before focusing the next window and the criteria used to select windows.

Back up your configuration before making changes.

## License

Choose a license before redistributing this project. If you want others to use, modify, and share it, consider the [MIT License](https://choosealicense.com/licenses/mit/).
