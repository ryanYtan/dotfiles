# dotfiles

Personal configuration files. Instructions below assume this repo is cloned to
`~/Projects/dotfiles` (the default `DOTFILES_DIR` in `zshrc`) — adjust paths if
you clone it elsewhere.

```sh
git clone <this-repo-url> ~/Projects/dotfiles
```

## zshrc

Symlink it into place, then edit the exports at the top for your own identity:

```sh
ln -sf ~/Projects/dotfiles/zshrc ~/.zshrc
```

Requires:

- [oh-my-zsh](https://ohmyz.sh/) installed at `~/.oh-my-zsh`
- `zsh-syntax-highlighting` plugin:
  ```sh
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```
- `nvm`, `uv`, and `keychain` (referenced/loaded by the script)

Edit `GIT_USERNAME` and `GIT_EMAIL` in `zshrc` before sourcing, since it runs
`git config --global` on startup. Set `DOTFILES_DIR` if this repo isn't at
`~/Projects/dotfiles`.

Open a new shell (or `source ~/.zshrc`) to pick up the changes.

## aliases_personal.zsh / aliases_work.zsh

Already sourced automatically by `zshrc` (via `$DOTFILES_DIR`) if both files
exist. Add your own aliases directly into these files — no extra install step
needed.

## vimrc

```sh
ln -sf ~/Projects/dotfiles/vimrc ~/.vimrc
```

Requires vim 8.1+. On first launch, it will auto-bootstrap
[vim-plug](https://github.com/junegunn/vim-plug) and run `:PlugInstall` for
you. If it doesn't trigger automatically, run `:PlugInstall` manually inside
vim.

## tmux.conf

```sh
ln -sf ~/Projects/dotfiles/tmux.conf ~/.tmux.conf
```

Reload an existing tmux session with `tmux source-file ~/.tmux.conf`, or just
start a new session. Note the prefix is remapped to `Ctrl+Space`.

## claude-statusline.sh

Status line script for [Claude Code](https://claude.com/claude-code). Copy or
symlink it somewhere stable and make it executable:

```sh
mkdir -p ~/.claude
ln -sf ~/Projects/dotfiles/claude-statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
```

Then point Claude Code at it in `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
}
```

Requires `jq` (`brew install jq`). Restart Claude Code (or run `/statusline`)
to pick it up.

## userChrome.css

Firefox tab/UI density tweaks.

1. Type `about:support` in the Firefox address bar and click **Open Folder**
   next to "Profile Folder" (macOS: **Show in Finder**).
2. Inside your profile folder, create a `chrome` directory if it doesn't
   already exist.
3. Copy (or symlink) `userChrome.css` into that `chrome` folder:
   ```sh
   ln -sf ~/Projects/dotfiles/userChrome.css <profile-folder>/chrome/userChrome.css
   ```
4. In `about:config`, ensure `toolkit.legacyUserProfileCustomizations.stylesheets`
   is set to `true`, and set the compact-mode prefs listed in the comment at
   the top of the file (`browser.compactmode.show`, `browser.uidensity`, etc.).
5. Restart Firefox.

## patches.reg

Windows registry tweaks (UTC clock, disable Caps Lock, disable search-in-Start,
faster menus, seconds in taskbar clock, disable NCSI active probing).

Double-click `patches.reg` in Windows Explorer, confirm the UAC prompt, and
accept the merge into the registry. **Read the file first** and comment out
any entries you don't want — this is applied system-wide and some tweaks
(Caps Lock remap, RealTimeIsUniversal) need a reboot to take effect. Useful
mainly if dual-booting with Linux (UTC clock keeps both OSes' clocks in sync).
