#
# This is test configuration git branch devel
#
isMaximal: {
  config.vim = { viAlias = false; vimAlias = false;
    debugMode = { enable = false; level = 16; logFile = "/tmp/nvim.log"; };

    spellcheck = {enable = false;};

    lsp = {
      # This must be enabled for the language modules to hook into
      # the LSP API.
      enable = true;

      # formatOnSave = true;
      formatOnSave = false; lspkind.enable = false; lightbulb.enable = true; lspsaga.enable = false; trouble.enable = true;
      otter-nvim.enable = isMaximal; lspSignature.enable = !isMaximal; # conflicts with blink in maximal
      # nvim-docs-view.enable = isMaximal;
      nvim-docs-view.enable = true;
    };

    debugger = { nvim-dap = { enable = true; ui.enable = true; }; };

    # This section does not include a comprehensive list of available language modules.
    # To list all available language module options, please visit the nvf manual.
    languages = {
      enableFormat = true; enableTreesitter = true; enableExtraDiagnostics = true;

      # Languages that will be supported in default and maximal configurations.
      nix.enable = true; markdown.enable = true;

      # Nim LSP is broken on Darwin and therefore
      # should be disabled by default. Users may still enable
      # `vim.languages.vim` to enable it, this does not restrict
      # that.
      # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
      nim.enable = false;
    };

    visuals = {
      nvim-scrollbar.enable = isMaximal;
      nvim-web-devicons.enable = true;
      nvim-cursorline.enable = true;
      cinnamon-nvim.enable = true;
      fidget-nvim.enable = true;

      highlight-undo.enable = true;
      indent-blankline.enable = true;

      # Fun
      cellular-automaton.enable = false;
    };

    theme = {
      enable = true; transparent = true;

      name = "catppuccin"; style = "mocha";
      # name = "gruvbox"; style = "dark";
      # name = "nord";
    };

    # nvf provides various autocomplete options. The tried and tested nvim-cmp
    # is enabled in default package, because it does not trigger a build. We
    # enable blink-cmp in maximal because it needs to build its rust fuzzy
    # matcher library.
    autocomplete = {
      nvim-cmp.enable = !isMaximal;
      blink-cmp.enable = isMaximal;
    };

    snippets.luasnip.enable = true;
    telescope.enable = true;
    treesitter.context.enable = true;
    notify = { nvim-notify.enable = true; };
    notes = { todo-comments.enable = true; };

    # filetree = { neo-tree = { enable = false; }; };
    # tabline = { nvimBufferline.enable = false; };
    # gestures = { gesture-nvim.enable = false; };
    # presence = { neocord.enable = false; };

    binds = { whichKey.enable = true; cheatsheet.enable = true; hardtime-nvim.enable = isMaximal; };
    # binds = { whichKey.enable = true; };
    # binds = { cheatsheet.enable = true; hardtime-nvim.enable = isMaximal; };

    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false; # throws an annoying debug message
    };

    minimap = {
      minimap-vim.enable = false;
      codewindow.enable = isMaximal; # lighter, faster, and uses lua for configuration
    };

    dashboard = { dashboard-nvim.enable = true; # alpha.enable = true;
    };

    projects = { project-nvim.enable = isMaximal; };

    utility = {
      ccc.enable = false; vim-wakatime.enable = false; diffview-nvim.enable = true;
      yanky-nvim.enable = false; oil-nvim.enable = true; icon-picker.enable = isMaximal;
      surround.enable = isMaximal; leetcode-nvim.enable = isMaximal; multicursors.enable = isMaximal;

      motion = {
        hop.enable = true;
        leap.enable = true;
      };

      images = {
        image-nvim.enable = false;
        img-clip.enable = isMaximal;
      };
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer.enable = true;
      modes-nvim.enable = false; # the theme looks terrible with catppuccin
      illuminate.enable = true;
      breadcrumbs = {
        enable = isMaximal;
        navbuddy.enable = isMaximal;
      };
      fastaction.enable = true;
    };

    assistant = {
      chatgpt.enable = false;
      copilot = { enable = false; cmp.enable = isMaximal; };
      codecompanion-nvim.enable = false;
      avante-nvim.enable = isMaximal;
    };

    #--- slm ---
    #-- plugins/true
    statusline = {
      lualine = {
        enable = true;
        theme = "auto";
      };
    };

    comments = {
      comment-nvim.enable = true;
    };

    autopairs.nvim-autopairs.enable = true;

    #-- plugins/false
    session = {nvim-session-manager.enable = false;};

    #-- keymaps
    keymaps = [
      # save, quit + delete
      { key = "<leader>bd"; mode = ["n"]; action = "<cmd>bdelete<cr>"; silent = false; desc = "bdelete"; }
      { key = "<leader>q"; mode = ["n"]; action = "<cmd>quit<cr>"; silent = false; desc = "quit"; }
      { key = "<leader>c"; mode = ["n"]; action = "<cmd>close<cr>"; silent = false; desc = "close window"; }
      { key = "<leader>o"; mode = ["n"]; action = "<cmd>only<cr>"; silent = false; desc = "quitall"; }
      { key = "<leader>qa"; mode = ["n"]; action = "<cmd>quitall<cr>"; silent = false; desc = "quitall"; }
      # Telescope
      { key = "<leader>cc"; mode = ["n"]; action = "<cmd>Telescope command_history<cr>"; silent = false; desc = "telescope command history"; }
      { key = "<leader>f"; mode = ["n"]; action = "<cmd>Telescope find_files<cr>"; silent = false; desc = "telescope find files"; }
      { key = "<leader>h"; mode = ["n"]; action = "<cmd>Telescope help_tags<cr>"; silent = false; desc = "telescope help tags"; }
      { key = "<leader><space>"; mode = ["n"]; action = "<cmd>Telescope buffers<cr>"; silent = false; desc = "telescope buffers"; }
      { key = "<leader>m"; mode = ["n"]; action = "<cmd>MarkdownPreview<cr>"; silent = false; desc = "MarkdownPreview"; }
      # divers
    ];
  };

}
