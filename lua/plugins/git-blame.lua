return {
  'f-person/git-blame.nvim',
  lazy = false,
  config = function ()
    require('gitblame').setup {
      enabled = true,
      date_format = '%x'
    }

  end,
}
