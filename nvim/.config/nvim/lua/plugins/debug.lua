return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      require("mason-nvim-dap").setup({
        ensure_installed = { "python" },
        handlers = {},
      })

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Debug file",
          program = "${file}",
          console = "integratedTerminal",
        },
        {
          type = "python",
          request = "launch",
          name = "Debug file with args",
          program = "${file}",
          args = function()
            return vim.split(vim.fn.input("Args: "), " ")
          end,
          console = "integratedTerminal",
        },
      }
    end,
    keys = {
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Conditional breakpoint",
      },
      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "Continue / start debug",
      },
      {
        "<leader>ds",
        function() require("dap").step_over() end,
        desc = "Step over",
      },
      {
        "<leader>di",
        function() require("dap").step_into() end,
        desc = "Step into",
      },
      {
        "<leader>do",
        function() require("dap").step_out() end,
        desc = "Step out",
      },
      {
        "<leader>dt",
        function() require("dap").terminate() end,
        desc = "Terminate debug",
      },
      {
        "<leader>du",
        function() require("dapui").toggle() end,
        desc = "Toggle debug UI",
      },
      {
        "<leader>dr",
        function() require("dapui").open({ reset = true }) end,
        desc = "Open debug REPL",
      },
    },
  },
}