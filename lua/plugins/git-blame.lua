return {
  'f-person/git-blame.nvim',
  lazy = false,
  config = function ()
    require('gitblame').setup {
      enabled = true,
      date_format = '%x',
      message_when_not_committed = 'Oh please, commit this !',
    }

  end,
}
