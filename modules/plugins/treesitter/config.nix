{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.lists) optionals;
  inherit (lib.strings) optionalString;
  inherit (lib.nvim.binds) mkSetBinding addDescriptionsToMappings;
  inherit (lib.nvim.lua) toLuaObject;
  inherit (lib.nvim.dag) entryBefore entryAfter;

  cfg = config.vim.treesitter;

  self = import ./treesitter.nix {inherit pkgs lib;};
  mappingDefinitions = self.options.vim.treesitter.mappings;
  mappings = addDescriptionsToMappings cfg.mappings mappingDefinitions;
in {
  config = mkIf cfg.enable {
    vim = {
      startPlugins = ["nvim-treesitter"];

      # cmp-treesitter doesn't work on blink.cmp
      autocomplete.nvim-cmp = mkIf config.vim.autocomplete.nvim-cmp.enable {
        sources = {treesitter = "[Treesitter]";};
        sourcePlugins = ["cmp-treesitter"];
      };

      treesitter.grammars = optionals cfg.addDefaultGrammars cfg.defaultGrammars;

      # incremental_selection module was removed in nvim-treesitter 0.10.0
      maps = mkIf cfg.incrementalSelection.enable {
        normal = mkSetBinding mappings.incrementalSelection.init ":lua local ok,m = pcall(require,'nvim-treesitter.incremental_selection'); if ok then m.init_selection() end<CR>";

        visualOnly = mkMerge [
          (mkSetBinding mappings.incrementalSelection.incrementByNode "<cmd>lua local ok,m = pcall(require,'nvim-treesitter.incremental_selection'); if ok then m.node_incremental() end<CR>")
          (mkSetBinding mappings.incrementalSelection.incrementByScope "<cmd>lua local ok,m = pcall(require,'nvim-treesitter.incremental_selection'); if ok then m.scope_incremental() end<CR>")
          (mkSetBinding mappings.incrementalSelection.decrementByNode "<cmd>lua local ok,m = pcall(require,'nvim-treesitter.incremental_selection'); if ok then m.node_decremental() end<CR>")
        ];
      };

      # For some reason treesitter highlighting does not work on start if this is set before syntax on
      pluginRC.treesitter-fold = mkIf cfg.fold (entryBefore ["basic"] ''
        -- This is required by treesitter-context to handle folds
        vim.o.foldmethod = "expr"
        vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        -- This is optional, but is set rather as a sane default.
        -- If unset, opened files will be folded by automatically as
        -- the files are opened
        vim.o.foldenable = false
      '');

      # nvim-treesitter 0.10.0 removed the configs module. Highlighting and
      # indentation are now configured via Neovim's built-in vim.treesitter API.
      pluginRC.treesitter = entryAfter ["basic"] ''
        local ts_highlight_disable = ${toLuaObject cfg.highlight.disable}
        local ts_indent_disable = ${toLuaObject cfg.indent.disable}

        ${optionalString cfg.highlight.enable ''
        vim.api.nvim_create_autocmd("FileType", {
          callback = function(ev)
            local ft = vim.bo[ev.buf].filetype
            local skip = (type(ts_highlight_disable) == "function" and ts_highlight_disable(ft, ev.buf))
              or (type(ts_highlight_disable) == "table" and vim.tbl_contains(ts_highlight_disable, ft))
            if not skip then
              local ok = pcall(vim.treesitter.start, ev.buf)
              if not ok then
                local extra = ${toLuaObject cfg.highlight.additionalVimRegexHighlighting}
                if extra == true or (type(extra) == "table" and vim.tbl_contains(extra, ft)) then
                  vim.bo[ev.buf].syntax = "on"
                end
              end
            end
          end,
        })
        ''}

        ${optionalString cfg.indent.enable ''
        vim.api.nvim_create_autocmd("FileType", {
          callback = function(ev)
            local ft = vim.bo[ev.buf].filetype
            local skip = type(ts_indent_disable) == "table" and vim.tbl_contains(ts_indent_disable, ft)
            if not skip then
              vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
            end
          end,
        })
        ''}
      '';
    };
  };
}
