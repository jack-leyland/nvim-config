--- This module will load a random colorscheme on nvim startup process.

local utils = require("utils")

local M = {}

-- Colorscheme to its directory name mapping, because colorscheme repo name is not necessarily
-- the same as the colorscheme name itself.
M.colorscheme2dir = {
  onedark = "onedark.nvim",
  edge = "edge",
  sonokai = "sonokai",
  gruvbox_material = "gruvbox-material",
  nord = "nord.nvim",
  dracula = "dracula",
  everforest = "everforest",
  nightfox = "nightfox.nvim",
  kanagawa = "kanagawa.nvim",
  catppuccin = "catppuccin",
  rose_pine = "rose-pine",
  onedarkpro = "onedarkpro.nvim",
  monokai = "monokai.nvim",
  material = "material.nvim",
}

M.gruvbox8 = function()
  -- Italic options should be put before colorscheme setting,
  -- see https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
  vim.g.gruvbox_italics = 1
  vim.g.gruvbox_italicize_strings = 1
  vim.g.gruvbox_filetype_hi_groups = 1
  vim.g.gruvbox_plugin_hi_groups = 1

  vim.cmd([[colorscheme gruvbox8_hard]])
end

M.onedark = function()
  vim.cmd([[colorscheme onedark]])
end

M.edge = function()
  vim.g.edge_enable_italic = 1
  vim.g.edge_better_performance = 1

  vim.cmd([[colorscheme edge]])
end

M.sonokai = function()
  vim.g.sonokai_enable_italic = 1
  vim.g.sonokai_better_performance = 1

  vim.cmd([[colorscheme sonokai]])
end

M.gruvbox_material = function()
  -- foreground option can be material, mix, or original
  vim.g.gruvbox_material_foreground = "material"
  --background option can be hard, medium, soft
  vim.g.gruvbox_material_background = "soft"
  vim.g.gruvbox_material_enable_italic = 1
  vim.g.gruvbox_material_better_performance = 1

  vim.cmd([[colorscheme gruvbox-material]])
end

M.nord = function()
  vim.cmd([[colorscheme nord]])
end

M.doom_one = function()
  vim.cmd([[colorscheme doom-one]])
end

M.everforest = function()
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_better_performance = 1

  vim.cmd([[colorscheme everforest]])
end

M.nightfox = function()
  vim.cmd([[colorscheme nordfox]])
end

M.kanagawa = function()
  vim.cmd([[colorscheme kanagawa]])
end

M.catppuccin = function()
  -- available option: latte, frappe, macchiato, mocha
  --vim.g.catppuccin_flavour = "frappe"

  require("catppuccin").setup()

  vim.cmd([[colorscheme catppuccin]])
end

M.rose_pine = function()
  require('rose-pine').setup({
    --- @usage 'main' | 'moon'
    dark_variant = 'moon',
  })

  -- set colorscheme after options
  vim.cmd('colorscheme rose-pine')
end

M.onedarkpro = function()
  -- set colorscheme after options
  vim.cmd('colorscheme onedark_vivid')
end

M.monokai = function()
  vim.cmd('colorscheme monokai_pro')
end

M.material = function ()
  vim.g.material_style = "oceanic"
  vim.cmd('colorscheme material')
end

M.dracula = function()
  require('dracula').setup()
  vim.cmd[[colorscheme dracula]]
end

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.rand_colorscheme = function()
  local colorscheme = utils.rand_element(vim.tbl_keys(M.colorscheme2dir))

  if not vim.tbl_contains(vim.tbl_keys(M), colorscheme) then
    local msg = "Invalid colorscheme: " .. colorscheme
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

    return
  end

  -- Load the colorscheme, because all the colorschemes are declared as opt plugins, so the colorscheme isn't loaded yet.
  local status = utils.add_pack(M.colorscheme2dir[colorscheme])

  if not status then
    local msg = string.format("Colorscheme %s is not installed. Run PackerSync to install.", colorscheme)
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })

    return
  end

  -- Load the colorscheme and its settings
  M[colorscheme]()

  if vim.g.logging_level == "debug" then
    local msg = "Colorscheme: " .. colorscheme

    vim.notify(msg, vim.log.levels.DEBUG, { title = "nvim-config" })
  end
end

local dracula = require("dracula")
dracula.setup({
  -- customize dracula color palette
  colors = {
    bg = "#282A36",
    fg = "#F8F8F2",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    orange = "#FFB86C",
    yellow = "#F1FA8C",
    green = "#50fa7b",
    purple = "#BD93F9",
    cyan = "#8BE9FD",
    pink = "#FF79C6",
    bright_red = "#FF6E6E",
    bright_green = "#69FF94",
    bright_yellow = "#FFFFA5",
    bright_blue = "#D6ACFF",
    bright_magenta = "#FF92DF",
    bright_cyan = "#A4FFFF",
    bright_white = "#FFFFFF",
    menu = "#21222C",
    visual = "#3E4452",
    gutter_fg = "#4B5263",
    nontext = "#3B4048",
  },
  -- show the '~' characters after the end of buffers
  show_end_of_buffer = true, -- default false
  -- use transparent background
  transparent_bg = false, -- default false
  -- set custom lualine background color
  lualine_bg_color = "#44475a", -- default nil
  -- set italic comment
  italic_comment = false, -- default false
  -- overrides the default highlights see `:h synIDattr`
  overrides = {
    -- Examples
    -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
    -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
    -- Nothing = {} -- clear highlight of Nothing
  },
})
vim.cmd[[colorscheme dracula]]