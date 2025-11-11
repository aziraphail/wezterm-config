<h2 align="center">My WezTerm Config</h2>

<p align="center">
  <a href="https://github.com/KevinSilvester/wezterm-config/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/KevinSilvester/wezterm-config?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41">
  </a>
  <a href="https://github.com/KevinSilvester/wezterm-config/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/KevinSilvester/wezterm-config?style=for-the-badge&logo=gitbook&color=B5E8E0&logoColor=D9E0EE&labelColor=302D41">
  </a>
  <a href="https://github.com/KevinSilvester/wezterm-config/actions/workflows/lint.yml">
    <img alt="Build" src="https://img.shields.io/github/actions/workflow/status/KevinSilvester/wezterm-config/lint.yml?&style=for-the-badge&logo=githubactions&label=CI&color=A6E3A1&logoColor=D9E0EE&labelColor=302D41">
  </a>
</p>

![screenshot](./.github/screenshots/wezterm.gif)

---

## Table of Contents

- [Overview](#overview)
- [Repository Layout](#repository-layout)
- [Quick Start](#quick-start)
- [Platform-Specific Setup](#platform-specific-setup)
- [Configuration & Customization](#configuration--customization)
- [Workflows & Utilities](#workflows--utilities)
- [Key Bindings](#key-bindings) _(existing tables below)_
- [References & Inspiration](#referencesinspirations)

---

## Overview

This repository is a batteries-included WezTerm profile that:

- Runs unchanged on Windows (native + WSL), macOS, and Linux.
- Ships curated visuals: Catppuccin-inspired palette, tab capsules, live status bars, and a backdrop library.
- Automates ergonomics: GPU adapter discovery, tab naming helpers, custom launch menu, and new-tab InputSelector.
- Keeps machine-specific tweaks outside version control via environment knobs or optional `config/*.lua` overrides.

If you drop this folder into `~/.config/wezterm` (Linux/macOS) or `%USERPROFILE%\.wezterm` (Windows), you immediately get the same terminal experience everywhere. Add wallpapers, adjust fonts, or toggle features without touching upstream WezTerm Lua.

## Repository Layout

| Path | Purpose |
| ---- | ------- |
| `wezterm.lua` | Entry point; chains `config/*`, seeds backdrop controller, registers custom events. |
| `config/appearance.lua` | Window cosmetics (colorscheme, WebGPU/OpenGL front-end, scrollbars, backgrounds). |
| `config/bindings.lua` | Key tables, modifier selection, and shortcut wiring for tabs/panes/backgrounds. |
| `config/domains.lua` | Declares SSH/Unix/WSL domains (Ubuntu + archlinux Bash by default). |
| `config/fonts.lua` | Font stack (FiraCode Nerd Font fallback) with per-OS sizing. |
| `config/general.lua` | Behavior toggles: scrollback, hyperlink rules, bell handling. |
| `config/launch.lua` | Default program/domain plus launch menu entries per OS; supports `config/launch_local.lua`. |
| `events/*` | GUI hooks (status bars, tab capsules, new-tab InputSelector, maximize-on-start). |
| `utils/*` | Shared helpers: env parsing, GPU adapter ranking, dynamic backdrop manager, status cell builder. |
| `backdrops/` | Wallpaper pack used by the background selector (safe to replace with your own images). |
| `colors/custom.lua` | Catppuccin Mocha variant consumed by the appearance module. |

## Quick Start

1. Install WezTerm **20240127-113634-bbcac864** or newer (nightly recommended).
2. Clone/copy this repo into the folder WezTerm reads:
   - macOS/Linux: `~/.config/wezterm`
   - Windows: `%USERPROFILE%\.wezterm`
3. Launch WezTerm.
   - Windows launches land inside **Ubuntu WSL Bash** by default (Arch is also available from the launcher).
   - macOS/Linux launches use `/bin/bash -l` by default.
4. Hit <kbd>F3</kbd> or right-click the **+** button to explore the custom launcher/new-tab InputSelector.
5. Use the key bindings in [Key Bindings](#key-bindings) to drive tabs, panes, backdrops, and key tables.

_Optional_: Uncomment and edit the helper calls in `wezterm.lua` to point the backdrop manager at a different image directory or to start in focus mode.

## Platform-Specific Setup

### Windows (native + WSL)

- This config expects **WSL distributions named `Ubuntu` and `archlinux`**. Adjust `config/domains.lua` if your distro names differ.
- New windows/tabs target the first WSL Bash domain (`wsl:ubuntu-bash`). Use <kbd>ALT</kbd>+<kbd>CTRL</kbd>+<kbd>T</kbd> or the launcher to open the other domain.
- PowerShell 7 (`pwsh`), Windows PowerShell, Command Prompt, Git Bash (auto-detected via Scoop), and Nushell stay in the launch menu for ad-hoc tabs.
- Modifier keys map to `ALT`/`ALT+CTRL` to avoid colliding with Windows key combos. Override with `WEZTERM_SUPER_KEY` if you prefer Win-key shortcuts.

### macOS

- Drop the repo into `~/.config/wezterm` (or symlink). Homebrew WezTerm works out of the box.
- Default shell: `/bin/bash -l`. Launcher entries also expose Zsh, Fish (`/opt/homebrew/bin/fish`), and Nushell (`/opt/homebrew/bin/nu`).
- The Command key acts as SUPER; <kbd>⌘</kbd>+<kbd>/</kbd> cycles wallpapers, <kbd>⌘</kbd>+<kbd>t</kbd> spawns tabs, etc.

### Linux (Arch + others)

- Place the repo under `~/.config/wezterm`.
- Default shell: `/bin/bash -l`. Launcher includes Fish, Zsh, and Nushell when available in `$PATH`.
- GPU adapter helper prioritizes Vulkan → OpenGL automatically (override via `WEZTERM_FRONT_END=OpenGL` if needed).

## Configuration & Customization

Most tweaks can be applied via environment variables (set once in your shell profile) or via optional local modules.

| Variable | Purpose | Default |
| -------- | ------- | ------- |
| `WEZTERM_FRONT_END` | Force `WebGpu`, `OpenGL`, or `Software`. | `WebGpu` |
| `WEZTERM_BACKDROP_DIR` | Custom wallpaper directory; overrides bundled `backdrops/`. | repo `backdrops/` |
| `WEZTERM_FOCUS_COLOR` | Solid color for focus mode background. | Catppuccin base |
| `WEZTERM_BACKDROP_FOCUS_MODE` | `true` to start with focus mode (no image). | `false` |
| `WEZTERM_DISABLE_RANDOM_BACKDROP` | `true` to skip random wallpaper on launch. | `false` |
| `WEZTERM_SUPER_KEY` | Modifier used for “SUPER” shortcuts (e.g., `CTRL|SHIFT`). | macOS: `SUPER`, others: `ALT` |
| `WEZTERM_FONT`, `WEZTERM_FONT_FALLBACK`, `WEZTERM_FONT_SIZE` | Override the font stack. | `FiraCode Nerd Font`, fallback `MesloLGM Nerd Font`, size per OS |
| `WEZTERM_DEFAULT_PROG` | Explicit command (`wezterm.shell_split` syntax) for new tabs/windows. | Per-OS Bash or empty (Windows WSL default domain) |
| `WEZTERM_DEFAULT_DOMAIN` | Force a specific domain (e.g., `wsl:archlinux-bash`). | First WSL domain on Windows |
| `WEZTERM_WSL_DISTROS` | Comma-separated list of distros to expose. | `Ubuntu,archlinux` |
| `WEZTERM_WSL_USER`, `WEZTERM_WSL_HOME` | Customize WSL username/home path. | `suhail`, `/home/suhail` |
| `WEZTERM_GIT_BASH` | Path to Git Bash executable if not installed via Scoop. | Auto-detected Scoop path |
| `WEZTERM_NUSHELL_EXE` | Nushell binary path on Windows. | `nu` |
| `WEZTERM_SSH_REMOTE`, `WEZTERM_SSH_DOMAIN_NAME`, `WEZTERM_SSH_MULTIPLEXING`, `WEZTERM_SSH_ASSUME_SHELL` | Define an SSH domain that appears in the launch menu and InputSelector. | Not defined |

### Host Overrides (optional)

- Create `config/launch_local.lua` and return `{ default_prog = {...}, launch_menu = {...} }` to replace the auto-generated tables on that machine. The file is required via `pcall`, so missing files are ignored.
- Symlink or copy `backdrops/` to a host-specific folder and point `WEZTERM_BACKDROP_DIR` at it.
- For heavier customization (e.g., per-host key bindings), require your own module inside `wezterm.lua` and append/override options after the existing chain.

## Workflows & Utilities

- **Backdrop Controller** (`utils/backdrops.lua`): loads all images under `backdrops/` (or your custom path), lets you randomize/cycle/fuzzy-search backgrounds, and toggles a distraction-free solid color. Controlled via <kbd>SUPER</kbd>+<kbd>/</kbd>, <kbd>SUPER</kbd>+<kbd>,</kbd>, <kbd>SUPER</kbd>+<kbd>.</kbd>, <kbd>SUPER_REV</kbd>+<kbd>/</kbd>, and <kbd>SUPER</kbd>+<kbd>b</kbd>.
- **GPU Adapter Picker** (`utils/gpu-adapter.lua`): enumerates adapters and chooses the best backend for each OS (Dx12/Vulkan/Metal). Change `WEZTERM_FRONT_END` if you need to force OpenGL.
- **Status Bars** (`events/left-status.lua`, `events/right-status.lua`): left badge shows active key table/leader status, right badge shows Catppuccin-styled date + battery info. Customize date format via `require('events.right-status').setup({ date_format = '%a %H:%M:%S' })` in `wezterm.lua`.
- **Tab Capsules** (`events/tab-title.lua`): render process-aware titles, unseen-output badges (circle/number), WSL/Admin icons, manual rename/undo events (<kbd>SUPER</kbd>+<kbd>0</kbd>/<kbd>SUPER_REV</kbd>+<kbd>0</kbd>), and tab-bar toggle (<kbd>SUPER</kbd>+<kbd>9</kbd>).
- **New Tab Button** (`events/new-tab-button.lua`): left-click behaves normally; right-click opens an InputSelector fed by the launch menu + domain list so you can spawn PowerShell, Git Bash, WSL Arch, SSH targets, etc.
- **GUI Startup** (`events/gui-startup.lua`): maximizes the initial WezTerm window for a distraction-free baseline.

---

### Features

- [**Background Image Selector**](https://github.com/KevinSilvester/wezterm-config/blob/master/utils/backdrops.lua)

  - Cycle images
  - Fuzzy search for image
  - Toggle background image

  > See: [key bindings](#background-images) for usage

- [**GPU Adapter Selector**](https://github.com/KevinSilvester/wezterm-config/blob/master/utils/gpu_adapter.lua)

  > :bulb: Only works if the [`front_end`](https://github.com/KevinSilvester/wezterm-config/blob/master/config/appearance.lua#L8) option is set to `WebGpu`.

  A small utility to select the best GPU + Adapter (graphics API) combo for your machine.

  GPU + Adapter combo is selected based on the following criteria:

  1.  <details>
      <summary>Best GPU available</summary>

      `Discrete` > `Integrated` > `Other` (for `wgpu`'s OpenGl implementation on Discrete GPU) > `Cpu`
      </details>

  2.  <details>
      <summary>Best graphics API available (based off my very scientific scroll a big log file in Neovim test 😁)</summary>

      > :bulb:<br>
      > The available graphics API choices change based on your OS.<br>
      > These options correspond to the APIs the `wgpu` crate (which powers WezTerm's gui in `WebGpu` mode)<br>
      > currently has support implemented for.<br>
      > See: <https://github.com/gfx-rs/wgpu#supported-platforms> for more info

      - Windows: `Dx12` > `Vulkan` > `OpenGl`
      - Linux: `Vulkan` > `OpenGl`
      - Mac: `Metal`

      </details>

---

### Getting Started

- ##### Requirements:

  - <details>
      <summary><b>WezTerm</b></summary>

    Minimum Version: `20240127-113634-bbcac864`<br>
    Recommended Version: [`Nightly`](https://github.com/wez/wezterm/releases/nightly)

    [Official Installation Page](https://wezfurlong.org/wezterm/installation.html)

    **Windows**

    - <details>
      <summary>Install Stable</summary>

      - Install with Scoop (non-portable)

        ```sh
        scoop bucket add extras
        scoop install wezterm
        ```

      - Install with Scoop (portable)

        ```sh
        scoop bucket add k https://github.com/KevinSilvester/scoop-bucket
        scoop install k/wezterm
        ```

      - Install with winget

        ```sh
        winget install wez.wezterm
        ```

      - Install with choco

        ```sh
        choco install wezterm -y
        ```
      </details>

    - <details>
      <summary>Install Nightly</summary>

      - Install with Scoop (non-portable)

        ```sh
        scoop bucket add versions
        scoop install wezterm-nightly
        ```

      - Install with Scoop (portable)

        ```sh
        scoop bucket add k https://github.com/KevinSilvester/scoop-bucket
        scoop install k/wezterm-nightly
        ```
      </details>

    > :bulb:<br>
    > Toast notifications don't work in non-portable installations.<br>
    > See issue <https://github.com/wez/wezterm/issues/5166> for more details
  
    ---

    **MacOS**

    - <details>
      <summary>Install Stable</summary>

      - Install with Homebrew

        ```sh
        brew install --cask wezterm
        ```

      - Install with MacPort

        ```sh
        sudo port selfupdate
        sudo port install wezterm
        ```
      </details>

    - <details>
      <summary>Install Nighlty</summary>

      - Install with Homebrew

        ```sh
        brew install --cask wezterm@nightly
        ```

      - Upgrade with Homebrew

        ```sh
        brew install --cask wezterm@nightly --no-quarantine --greedy-latest
        ```
      </details>

    ---

    **Linux**

    Refer to the Linux installation page.<br>
    <https://wezfurlong.org/wezterm/install/linux.html>

    </details>

  - <details>
    <summary>JetBrainsMono Nerd Font</summary>

    Install with Homebrew (Macos)

    ```sh
    brew tap homebrew/cask-fonts
    brew install font-jetbrains-mono-nerd-font
    ```

    Install with Scoop (Windows)

    ```sh
    scoop bucket add nerd-fonts
    scoop install JetBrainsMono-NF
    ```

    > More Info:
    >
    > - <https://www.nerdfonts.com/#home>
    > - <https://github.com/ryanoasis/nerd-fonts?#font-installation>
    </details/>

&nbsp;

- ##### Steps:

  1.  ```sh
      # On Windows and Unix systems
      git clone https://github.com/KevinSilvester/wezterm-config.git ~/.config/wezterm
      ```
  2.  And Done!!! 🎉🎉

&nbsp;

- ##### Things You Might Want to Change:

  - [./config/domains.lua](./config/domains.lua) for custom SSH/WSL domains
  - [./config/launch.lua](./config/launch.lua) for preferred shells and its paths

---

### All Key Bindings

Most of the key bindings revolve around a <kbd>SUPER</kbd> and <kbd>SUPER_REV</kbd>(super reversed) keys.<br>

- On MacOs:
  - <kbd>SUPER</kbd> ⇨ <kbd>Super</kbd>
  - <kbd>SUPER_REV</kbd> ⇨ <kbd>Super</kbd>+<kbd>Ctrl</kbd>
- On Windows and Linux
  - <kbd>SUPER</kbd> ⇨ <kbd>Alt</kbd>
  - <kbd>SUPER_REV</kbd> ⇨ <kbd>Alt</kbd>+<kbd>Ctrl</kbd>

> To avoid confusion when switching between different OS and to avoid conflicting<br>
> with OS's built-in keyboard shortcuts.

- On all platforms: <kbd>LEADER</kbd> ⇨ <kbd>SUPER_REV</kbd>+<kbd>Space</kbd>

#### Miscellaneous/Useful

| Keys                              | Action                                      |
| --------------------------------- | ------------------------------------------- |
| <kbd>F1</kbd>                     | `ActivateCopyMode`                          |
| <kbd>F2</kbd>                     | `ActivateCommandPalette`                    |
| <kbd>F3</kbd>                     | `ShowLauncher`                              |
| <kbd>F4</kbd>                     | `ShowLauncher` <sub>(tabs only)</sub>       |
| <kbd>F5</kbd>                     | `ShowLauncher` <sub>(workspaces only)</sub> |
| <kbd>F11</kbd>                    | `ToggleFullScreen`                          |
| <kbd>F12</kbd>                    | `ShowDebugOverlay`                          |
| <kbd>SUPER</kbd>+<kbd>f</kbd>     | Search Text                                 |
| <kbd>SUPER_REV</kbd>+<kbd>u</kbd> | Open URL                                    |

&nbsp;

#### Copy+Paste

| Keys                                          | Action               |
| --------------------------------------------- | -------------------- |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>c</kbd> | Copy to Clipboard    |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>v</kbd> | Paste from Clipboard |

&nbsp;

#### Cursor Movements

| Keys                                   | Action                                                     |
| -------------------------------------- | ---------------------------------------------------------- |
| <kbd>SUPER</kbd>+<kbd>LeftArrow</kbd>  | Move cursor to Line Start                                  |
| <kbd>SUPER</kbd>+<kbd>RightArrow</kbd> | Move cursor to Line End                                    |
| <kbd>SUPER</kbd>+<kbd>Backspace</kbd>  | Clear Line <sub>(does not work in PowerShell or cmd)</sub> |

&nbsp;

#### Tabs

##### Tabs: Spawn+Close

| Keys                              | Action                                |
| --------------------------------- | ------------------------------------- |
| <kbd>SUPER</kbd>+<kbd>t</kbd>     | `SpawnTab` <sub>(DefaultDomain)</sub> |
| <kbd>SUPER_REV</kbd>+<kbd>f</kbd> | `SpawnTab` <sub>(WSL:Ubuntu)</sub>    |
| <kbd>SUPER_REV</kbd>+<kbd>w</kbd> | `CloseCurrentTab`                     |

##### Tabs: Navigation

| Keys                              | Action         |
| --------------------------------- | -------------- |
| <kbd>SUPER</kbd>+<kbd>[</kbd>     | Next Tab       |
| <kbd>SUPER</kbd>+<kbd>]</kbd>     | Previous Tab   |
| <kbd>SUPER_REV</kbd>+<kbd>[</kbd> | Move Tab Left  |
| <kbd>SUPER_REV</kbd>+<kbd>]</kbd> | Move Tab Right |

##### Tabs: Toggle Tab-bar

| Keys                          | Action         |
| ----------------------------- | -------------- |
| <kbd>SUPER</kbd>+<kbd>9</kbd> | Toggle tab bar |

##### Tabs: Title

| Keys                              | Action             |
| --------------------------------- | ------------------ |
| <kbd>SUPER</kbd>+<kbd>0</kbd>     | Rename Current Tab |
| <kbd>SUPER_REV</kbd>+<kbd>0</kbd> | Undo Rename        |

&nbsp;

#### Windows

| Keys                          | Action               |
| ----------------------------- | -------------------- |
| <kbd>SUPER</kbd>+<kbd>n</kbd> | `SpawnWindow`        |
| <kbd>SUPER</kbd>+<kbd>=</kbd> | Increase Window Size |
| <kbd>SUPER</kbd>+<kbd>-</kbd> | Decrease Window Size |

&nbsp;

#### Panes

##### Panes: Split Panes

| Keys                               | Action                                           |
| ---------------------------------- | ------------------------------------------------ |
| <kbd>SUPER</kbd>+<kbd>\\</kbd>     | `SplitVertical` <sub>(CurrentPaneDomain)</sub>   |
| <kbd>SUPER_REV</kbd>+<kbd>\\</kbd> | `SplitHorizontal` <sub>(CurrentPaneDomain)</sub> |

##### Panes: Zoom+Close Pane

| Keys                              | Action                |
| --------------------------------- | --------------------- |
| <kbd>SUPER</kbd>+<kbd>Enter</kbd> | `TogglePaneZoomState` |
| <kbd>SUPER</kbd>+<kbd>w</kbd>     | `CloseCurrentPane`    |

##### Panes: Navigation

| Keys                              | Action                  |
| --------------------------------- | ----------------------- |
| <kbd>SUPER_REV</kbd>+<kbd>k</kbd> | Move to Pane (Up)       |
| <kbd>SUPER_REV</kbd>+<kbd>j</kbd> | Move to Pane (Down)     |
| <kbd>SUPER_REV</kbd>+<kbd>h</kbd> | Move to Pane (Left)     |
| <kbd>SUPER_REV</kbd>+<kbd>l</kbd> | Move to Pane (Right)    |
| <kbd>SUPER_REV</kbd>+<kbd>p</kbd> | Swap with selected Pane |

##### Panes: Scroll Pane

| Keys                          | Action                               |
| ----------------------------- | ------------------------------------ |
| <kbd>SUPER</kbd>+<kbd>u</kbd> | Scroll Lines up <sub>5 lines</sub>   |
| <kbd>SUPER</kbd>+<kbd>d</kbd> | Scroll Lines down <sub>5 lines</sub> |
| <kbd>PageUp</kbd>             | Scroll Page up                       |
| <kbd>PageDown</kbd>           | Scroll Page down                     |

&nbsp;

#### Background Images

| Keys                              | Action                       |
| --------------------------------- | ---------------------------- |
| <kbd>SUPER</kbd>+<kbd>/</kbd>     | Select Random Image          |
| <kbd>SUPER</kbd>+<kbd>,</kbd>     | Cycle to next Image          |
| <kbd>SUPER</kbd>+<kbd>.</kbd>     | Cycle to previous Image      |
| <kbd>SUPER_REV</kbd>+<kbd>/</kbd> | Fuzzy select Image           |
| <kbd>SUPER</kbd>+<kbd>b</kbd>     | Toggle background focus mode |

&nbsp;

#### Key Tables

> See: <https://wezfurlong.org/wezterm/config/key-tables.html>

| Keys                           | Action        |
| ------------------------------ | ------------- |
| <kbd>LEADER</kbd>+<kbd>f</kbd> | `resize_font` |
| <kbd>LEADER</kbd>+<kbd>p</kbd> | `resize_pane` |

##### Key Table: `resize_font`

| Keys           | Action                          |
| -------------- | ------------------------------- |
| <kbd>k</kbd>   | `IncreaseFontSize`              |
| <kbd>j</kbd>   | `DecreaseFontSize`              |
| <kbd>r</kbd>   | `ResetFontSize`                 |
| <kbd>q</kbd>   | `PopKeyTable` <sub>(exit)</sub> |
| <kbd>Esc</kbd> | `PopKeyTable` <sub>(exit)</sub> |

##### Key Table: `resize_pane`

| Keys           | Action                                         |
| -------------- | ---------------------------------------------- |
| <kbd>k</kbd>   | `AdjustPaneSize` <sub>(Direction: Up)</sub>    |
| <kbd>j</kbd>   | `AdjustPaneSize` <sub>(Direction: Down)</sub>  |
| <kbd>h</kbd>   | `AdjustPaneSize` <sub>(Direction: Left)</sub>  |
| <kbd>l</kbd>   | `AdjustPaneSize` <sub>(Direction: Right)</sub> |
| <kbd>q</kbd>   | `PopKeyTable` <sub>(exit)</sub>                |
| <kbd>Esc</kbd> | `PopKeyTable` <sub>(exit)</sub>                |

---

### References/Inspirations

- <https://github.com/rxi/lume>
- <https://github.com/catppuccin/wezterm>
- <https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614>
- <https://github.com/wez/wezterm/discussions/628#discussioncomment-5942139>
