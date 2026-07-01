<div align="center">

<h1>
zsh-ctrl-z
</h1>

A lightweight zsh plugin that enhances the default `CTRL+Z` behavior using `fzf`. It allows you to visually browse, resume, or terminate suspended background jobs directly from your terminal prompt.

<p align="center" width="100%">
<video src=https://github.com/user-attachments/assets/4744c98d-a27e-4271-a820-2a807bde2e8f width="80%" controls></video>
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
    Add this line to `${ZDOTDIR:-$HOME}/.zsh_plugins.txt` bundle file:
    ```
    Zile995/zsh-ctrl-z
    ```
  - ## Sheldon
    Add these lines to `plugins.toml` file:

    ```R
    [plugins.zsh-ctrl-z]
    github = "Zile995/zsh-ctrl-z"
    ```

# Shortcuts

When the `fzf` menu is open, you can use the following shortcuts:

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `ENTER` / `Double-Click` | **Foreground** | Brings the selected job to the foreground. |
| `CTRL-Z` | **Foreground** | Brings the selected job to the foreground (consistent with Enter). |
| `CTRL-K` | **Kill Single** | Sends `SIGKILL` to the selected background job. |
| `CTRL-X` | **Kill ALL** | Sends `SIGKILL` to **all** active background jobs instantly. |
| `ESC` | **Exit** | Closes the interface without shifting any jobs. |
