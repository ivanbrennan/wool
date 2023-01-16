local colorscheme = dofile("lua/lush_theme/wool.lua")
local lushwright = require("shipwright.transform.lush")

run(colorscheme,
  lushwright.to_vimscript,
  {append, {"set background=dark", "let g:colors_name=\"wool\""}},
  {overwrite, "colors/wool.vim"})

run(colorscheme,
  lushwright.to_vimscript,
  lushwright.vim_compatible_vimscript,
  {append, {"set background=dark", "let g:colors_name=\"wool-compatible\""}},
  {overwrite, "colors/wool-compatible.vim"})
