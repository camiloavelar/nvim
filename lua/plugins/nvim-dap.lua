return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go"
  },
  lazy = false,
  config = function ()
    require("dap-go").setup({
      dap_configurations = {
        {
          type = "go",
          name = "Debug server",
          request = "launch",
          program = "${file}",
          args = {'server'},
        },
      }
    })
    require("dapui").setup()

    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.after.event_initialized["dapui_config"]=function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"]=function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"]=function()
      dapui.close()
    end
    dap.listeners.before.disconnect["dapui_config"] = function()
      dapui.close()
    end

    -- vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
    -- vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})
    local namespace = vim.api.nvim_create_namespace("dap-hlng")
    vim.api.nvim_set_hl(namespace, 'DapBreakpoint', { fg='#eaeaeb', bg='#ffffff' })
    vim.api.nvim_set_hl(namespace, 'DapLogPoint', { fg='#eaeaeb', bg='#ffffff' })
    vim.api.nvim_set_hl(namespace, 'DapStopped', { fg='#eaeaeb', bg='#ffffff' })

    vim.fn.sign_define('DapBreakpoint', { text='•', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

    vim.keymap.set('n', '<leader>da', require 'dap'.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dc', require 'dap'.terminate)
    vim.keymap.set('n', '<F5>', require 'dap'.continue)
    vim.keymap.set('n', '<F10>', require 'dap'.step_over)
    vim.keymap.set('n', '<F11>', require 'dap'.step_into)
    vim.keymap.set('n', '<F12>', require 'dap'.step_out)
  end
}
