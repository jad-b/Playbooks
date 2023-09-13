return {
    'mfussenegger/nvim-jdtls',
    'tpope/vim-vinegar',
    'tpope/vim-unimpaired',
    'tpope/vim-surround',
    'tpope/vim-dispatch',
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-lua/plenary.nvim'
        -- 'nvim-telescope/telescope-dap.nvim',
        -- 'nvim-telescope/telescope-ui-select.nvim',
      },
      config = function() require('config/telescope') end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {}
      end,
    },
    {
      'tanvirtin/monokai.nvim',
      config = function ()
        require('monokai').setup {}
        require('monokai').setup { palette = require('monokai').pro }
        require('monokai').setup { palette = require('monokai').soda }
        require('monokai').setup { palette = require('monokai').ristretto }
      end
    },
}
