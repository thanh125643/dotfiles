local vimp = require('vimp')
-- reload nvim
function _G.ReloadConfig()
    vimp.unmap_all()
    require("plenary.reload").reload_module("nguyen")
    dofile(vim.env.MYVIMRC)
end
