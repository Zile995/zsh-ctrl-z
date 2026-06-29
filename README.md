<div align="center">

<h1>
zsh-ctrl-z
</h1>

A lightweight zsh plugin that enhances the default `CTRL+Z` behavior using `fzf`. It allows you to visually browse, resume, or terminate suspended background jobs directly from your terminal prompt.

<p align="center" width="100%">
<video src=https://github.com/user-attachments/assets/d2c0d910-3f4e-4d27-8597-d19551579233 width="80%" controls></video>
</p>
</div>

# Features
- **Quick-Resume**: If only one background job exists, pressing `CTRL+Z` instantly brings it back to the foreground without opening the fzf.
- **Interactive Menu**: If multiple jobs are running, it opens an `fzf` list.
- **Process Termination**: Kill frozen or unwanted background jobs directly from the menu without leaving the interface.

# Dependencies:
  - `fzf`
  - `nerd-fonts`

# Installation
  - ## Manual
    ```Shell
    git clone --depth=1 https://github.com/Zile995/zsh-ctrl-z.git ${ZDOTDIR:-$HOME}/zsh-ctrl-z
    echo 'source ${ZDOTDIR:-$HOME}/zsh-ctrl-z/zsh-ctrl-z.zsh' >>${ZDOTDIR:-$HOME}/.zshrc
    ```
  - ## Antidote
    Add this line to `${ZDOTDIR:-$HOME}/.zsh_plugins` bundle file:
    ```
    Zile995/zsh-ctrl-z
    ```
  - ## Sheldon
    Add these lines to `plugins.toml` file:

    ```R
    [plugins.zsh-ctrl-z]
    github = "Zile995/zsh-ctrl-z"
    ```

# Keybindings

When the `fzf` menu is open, you can use the following shortcuts:

| Keybinding | Action |
|------------|--------|
| `Enter` / `CTRL+Z` | Bring the selected job to the foreground (`fg`) |
| `CTRL+K` | Instantly terminate the selected job (`kill -KILL`) |
| `ESC` / `CTRL+C` | Exit the menu and return to the prompt |
