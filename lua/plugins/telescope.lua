return {
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-dap.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      require('telescope').load_extension 'dap'
      require('telescope').setup {
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      }
    end,
    cmd = 'Telescope',
    keys = {
      -- {
      --   'gr',
      --   function()
      --     require('telescope.builtin').lsp_references()
      --   end,
      -- },
      --
      -- {
      --   '<leader>ds',
      --   function()
      --     require('telescope.builtin').lsp_document_symbols()
      --   end,
      -- },
      -- {
      --   '<leader>dS',
      --   function()
      --     require('telescope.builtin').lsp_workspace_symbols()
      --   end,
      -- },
      -- {
      --   '<C-y>',
      --   function()
      --     require('telescope.builtin').buffers { show_all_buffers = true }
      --   end,
      -- },
      --
      -- {
      --   '<leader>tc',
      --   function()
      --     require('telescope.builtin').commands()
      --   end,
      -- },
      -- {
      --   '<leader>th',
      --   function()
      --     require('telescope.builtin').command_history()
      --   end,
      -- },
      -- {
      --   '<leader>tH',
      --   function()
      --     require('telescope.builtin').highlights()
      --   end,
      -- },
      -- {
      --   '<leader>tk',
      --   function()
      --     require('telescope.builtin').keymaps()
      --   end,
      -- },
      -- {
      --   '<leader>tr',
      --   function()
      --     require('telescope.builtin').registers()
      --   end,
      -- },
      -- {
      --   '<leader>to',
      --   function()
      --     require('telescope.builtin').vim_options()
      --   end,
      -- },
      -- {
      --   '<leader>tm',
      --   function()
      --     require('telescope.builtin').help_tags()
      --   end,
      -- },
      -- {
      --   '<leader>ti',
      --   function()
      --     require('telescope.builtin').highlights()
      --   end,
      -- },
      -- {
      --   '<leader>tg',
      --   function()
      --     require('telescope.builtin').live_grep()
      --   end,
      -- },
      -- {
      --   '<leader>tw',
      --   function()
      --     require('telescope.builtin').grep_string()
      --   end,
      -- },
      -- {
      --   '<leader>ts',
      --   function()
      --     require('telescope.builtin').spell_suggest()
      --   end,
      -- },
      -- {
      --   '<leader>tq',
      --   function()
      --     require('telescope.builtin').quickfix()
      --   end,
      -- },
      -- {
      --   '<leader>tf',
      --   function()
      --     require('telescope.builtin').oldfiles()
      --   end,
      -- },
      -- {
      --   '<C-p>',
      --   function()
      --     require('telescope.builtin').find_files()
      --   end,
      -- },
      -- {
      --   '<leader>gb',
      --   function()
      --     require('telescope.builtin').git_branches()
      --   end,
      -- },
      -- {
      --   '<leader>gs',
      --   function()
      --     require('telescope.builtin').git_stash()
      --   end,
      -- },
      -- {
      --   '<leader>gc',
      --   function()
      --     require('telescope.builtin').git_commits()
      --   end,
      -- },
    },
  },
}
