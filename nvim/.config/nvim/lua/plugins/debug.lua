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
      local dap_python = require("dap-python")

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
        handlers = {}, -- mason wires up debugpy; no dap-python.setup() needed
      })

      dap_python.test_runner = "pytest"

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Debug file",
          program = "${file}",
          console = "integratedTerminal",
          justMyCode = false,
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
          justMyCode = false,
        },
        {
          type = "python",
          request = "launch",
          name = "Pytest: current file",
          module = "pytest",
          args = { "${file}", "-vv", "-s" },
          console = "integratedTerminal",
          justMyCode = false,
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
        "<leader>dT",
        function() require("dap-python").test_method() end,
        desc = "Debug pytest at cursor",
      },
      {
        "<leader>dF",
        function()
          require("dap").run({
            type = "python",
            request = "launch",
            name = "Pytest: current file",
            module = "pytest",
            args = { vim.api.nvim_buf_get_name(0), "-vv", "-s" },
            console = "integratedTerminal",
            justMyCode = false,
          })
        end,
        desc = "Debug pytest file",
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