return {
  'nvim-tree/nvim-web-devicons',
  config = function()
    require('nvim-web-devicons').setup({
      override = {
        go = {
          icon = '󰟓',
          color = '#00ADD8',
          name = 'Go',
        }
      }
    })
  end,
}
