local vimp = require('vimp')
local cmd = vim.cmd

vimp.nnoremap({'silent'}, '<leader>r', '<cmd>lua ReloadConfig()<cr>')

vimp.nnoremap({'silent'}, '<C-n>', '<cmd>NvimTreeToggle<cr>')
vimp.nnoremap({'silent'}, '<leader>tr', '<cmd>NvimTreeRefresh<cr>')
vimp.nnoremap({'silent'}, '<leader>mf', '<cmd>NvimTreeFindFile<cr>')

vimp.nnoremap({'silent'}, '<leader>ff', '<cmd>Telescope find_files<cr>')
vimp.nnoremap({'silent'}, '<leader>fg', '<cmd>Telescope live_grep<cr>')
vimp.nnoremap({'silent'}, '<leader>fb', '<cmd>Telescope buffers<cr>')
vimp.nnoremap({'silent'}, '<leader>fh', '<cmd>Telescope help_tags<cr>')

vimp.nmap('<C-p>', '<Plug>MarkdownPreviewToggle')

vimp.inoremap('ii', '<Esc>')

vimp.add_chord_cancellations('n', '<leader>')

cmd('command! ReloadConfig lua ReloadConfig()')
