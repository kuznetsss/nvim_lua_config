if vim.g.neovide == nil then
  return
end

local nix_bin = vim.fn.expand '~/.nix-profile/bin'
if not (':' .. vim.env.PATH .. ':'):find(':' .. nix_bin .. ':', 1, true) then
  vim.env.PATH = nix_bin .. ':' .. vim.env.PATH
end

vim.o.guifont = 'JetBrainsMono Nerd Font:h14'
vim.g.neovide_confirm_quit = true
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_hide_mouse_when_typing = true
vim.keymap.set({ 'n', 'i', 'v', 'c', 't' }, '<D-v>', function()
  vim.api.nvim_paste(vim.fn.getreg '+', true, -1)
end)
-- Tomorrow (dark) (terminal.sexy) theme
vim.g.terminal_color_0 = '#1d1f21' -- black
vim.g.terminal_color_1 = '#cc6666' -- red
vim.g.terminal_color_2 = '#b5bd68' -- green
vim.g.terminal_color_3 = '#f0c674' -- yellow
vim.g.terminal_color_4 = '#81a2be' -- blue
vim.g.terminal_color_5 = '#b294bb' -- magenta
vim.g.terminal_color_6 = '#8abeb7' -- cyan
vim.g.terminal_color_7 = '#c5c8c6' -- white

vim.g.terminal_color_8 = '#666666' -- bright black
vim.g.terminal_color_9 = '#d54e53' -- bright red
vim.g.terminal_color_10 = '#b9ca4a' -- bright green
vim.g.terminal_color_11 = '#e7c547' -- bright yellow
vim.g.terminal_color_12 = '#7aa6da' -- bright blue
vim.g.terminal_color_13 = '#c397d8' -- bright magenta
vim.g.terminal_color_14 = '#70c0b1' -- bright cyan
vim.g.terminal_color_15 = '#eaeaea' -- bright white
