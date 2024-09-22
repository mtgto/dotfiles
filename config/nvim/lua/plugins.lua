return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  {
    'tanvirtin/monokai.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme monokai]])
    end,
  }
}
