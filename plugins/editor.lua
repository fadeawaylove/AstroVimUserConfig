return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1,
        width = function() return math.min(120, vim.o.columns * 0.75) end,
        height = 0.9,
        options = {
          number = false,
          relativenumber = false,
          foldcolumn = "0",
          list = false,
          showbreak = "NONE",
          signcolumn = "no",
        },
      },
      plugins = {
        options = {
          cmdheight = 1,
          laststatus = 0,
        },
      },
      on_open = function() -- disable diagnostics and indent blankline
        vim.g.diagnostics_mode_old = vim.g.diagnostics_mode
        vim.g.diagnostics_mode = 0
        vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[0])
        vim.g.indent_blankline_enabled_old = vim.g.indent_blankline_enabled
        vim.g.indent_blankline_enabled = false
      end,
      on_close = function() -- restore diagnostics and indent blankline
        vim.g.diagnostics_mode = vim.g.diagnostics_mode_old
        vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[vim.g.diagnostics_mode])
        vim.g.indent_blankline_enabled = vim.g.indent_blankline_enabled_old
      end,
    },
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      snippet_engine = "luasnip",
      languages = {
        lua = { template = { annotation_convention = "emmylua" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        typescriptreact = { template = { annotation_convention = "tsdoc" } },
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
      action_keys = {
        close = { "q", "<esc>" },
        cancel = "<c-e>",
      },
    },
  },
  { "willothy/flatten.nvim", lazy = false, priority = 1001, opts = { window = { open = "vsplit" } } },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      ignore_lsp = { "lua_ls", "julials" },
    },
    config = function(_, opts) require("project_nvim").setup(opts) end,
  },
}
