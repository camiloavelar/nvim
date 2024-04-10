local mapkey = require("util.keymapper").mapkey

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = false,
  keys = {
    mapkey("<leader><Tab>", "BufferLineCycleNext", "n"),
    mapkey("<leader>bc", "BufferLineCloseOthers", "n"),

    mapkey("<leader>b1", "BufferLineGoToBuffer 1", "n"),
    mapkey("<leader>b2", "BufferLineGoToBuffer 2", "n"),
    mapkey("<leader>b3", "BufferLineGoToBuffer 3", "n"),
    mapkey("<leader>b4", "BufferLineGoToBuffer 4", "n"),
    mapkey("<leader>b5", "BufferLineGoToBuffer 5", "n"),
    mapkey("<leader>b6", "BufferLineGoToBuffer 6", "n"),
    mapkey("<leader>b7", "BufferLineGoToBuffer 7", "n"),
    mapkey("<leader>b8", "BufferLineGoToBuffer 8", "n"),
    mapkey("<leader>b9", "BufferLineGoToBuffer 9", "n"),
    vim.keymap.set("n", "<leader>E", function()
      if vim.o.showtabline == 1 then
        vim.o.showtabline = 2
      else
        vim.o.showtabline = 1
      end
    end, { desc = "Toggle bufferline"}),
  },
  config = function ()
    vim.opt.termguicolors = true
    vim.opt.mousemoveevent = true

    require("bufferline").setup{
      options = {
        numbers = "ordinal",
        always_show_bufferline = false,
        sort_by = "insert_at_end",
        hover = {
          enabled = true,
          delay = 100,
          reveal = {'close'}
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
            separator = true,
          }
        }
      },
    }
  end
}
