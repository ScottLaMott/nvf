## nvf +- neovim Configruation Framework -+ ng - new generation

### Beschreibung

- Die Grundkonfiguration wird in ./configuration.nix gemacht. Plugins werden hier ein/ausgeschaltet.
- plugins sind in ~/.local/share/nvim/lazy

### Plugins

#### von mir installierte Plugins

- oil-nvim
- lazygit

### Todos

- harpoon
- markdown-preview

### Done

- git/lazygit - aufruf mit ```\<space>gg ...
- <leader>q quit buffer
- <leader>c command history 
- <leader><space> open buffer list
  - keymaps in ./configuration.nix
- git - repository auf github  ScottLaMott

### Web Links

##### NVF

- [nvf - Git-Page](https://github.com/NotAShelf/nvf)
- [nvf - nvf Manual](https://notashelf.github.io/nvf/index.xhtml)
- [nvf - Configuration Options](https://notashelf.github.io/nvf/options.html)

##### Neovim-Plugins

- [oil.nvim](https://github.com/stevearc/oil.nvim)
- [harpoon](https://github.com/ThePrimeagen/harpoon)
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
- [dummy](https://)

##### andere Neovims

- [LazyVim](https://lazyvim-ambitious-devs.phillips.codes)
- [must have neovim keybindings](https://medium.com/unixification/must-have-neovim-keymaps-51c283394070)

### Commands

```
# nvf framework clonen
> git clone https://github.com/NotAShelf/nvf.git

> nix shell # erzeugt shell 
> nix run # startet nvim 
> nix build # erzeugt nvim-executable in result/bin
> nix develop # erzeugt developer shell
```
