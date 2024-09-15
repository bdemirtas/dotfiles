return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "AckslD/muren.nvim",
    config = function()
      require("muren").setup {
        -- ui sizes
        patterns_width = 50,
        patterns_height = 20,
        options_width = 30,
        preview_height = 12,
      }
    end,
  },
  {
    "mbbill/undotree",
    keys = {
      { "<Leader><F5>", "<Cmd>UndotreeToggle<CR>", desc = "Toggle undotree window", mode = "n", silent = true },
    },
  },
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup {}
    end,
    event = "VeryLazy",
  },
  {
    "danilamihailov/beacon.nvim",
  },
  {
    "jake-stewart/multicursor.nvim",
    config = function()
      local mc = require "multicursor-nvim"

      mc.setup()

      -- add cursors above/below the main cursor
      vim.keymap.set({ "n", "v" }, "<up>", function()
        mc.addCursor "k"
      end)
      vim.keymap.set({ "n", "v" }, "<down>", function()
        mc.addCursor "j"
      end)

      -- add a cursor and jump to the next word under cursor
      vim.keymap.set({ "n", "v" }, "<c-n>", function()
        mc.addCursor "*"
      end)

      -- jump to the next word under cursor but do not add a cursor
      vim.keymap.set({ "n", "v" }, "<c-s>", function()
        mc.skipCursor "*"
      end)

      -- rotate the main cursor
      vim.keymap.set({ "n", "v" }, "<left>", mc.nextCursor)
      vim.keymap.set({ "n", "v" }, "<right>", mc.prevCursor)

      -- delete the main cursor
      vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor)

      -- add and remove cursors with control + left click
      vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

      vim.keymap.set({ "n", "v" }, "<c-q>", function()
        if mc.cursorsEnabled() then
          -- stop other cursors from moving. this allows you to reposition the main cursor
          mc.disableCursors()
        else
          mc.addCursor()
        end
      end)

      vim.keymap.set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- default <esc> handler
        end
      end)

      -- align cursor columns
      vim.keymap.set("n", "<leader>a", mc.alignCursors)

      -- split visual selections by regex
      vim.keymap.set("v", "S", mc.splitCursors)

      -- match new cursors within visual selections by regex
      vim.keymap.set({ "n", "v" }, "M", mc.matchCursors)

      -- rotate visual selection contents
      vim.keymap.set("v", "<leader>t", function()
        mc.transposeCursors(1)
      end)
      vim.keymap.set("v", "<leader>T", function()
        mc.transposeCursors(-1)
      end)

      -- customize how cursors look
      vim.cmd.hi("link", "MultiCursorCursor", "Cursor")
      vim.cmd.hi("link", "MultiCursorVisual", "Visual")
      vim.cmd.hi("link", "MultiCursorDisabledCursor", "Visual")
      vim.cmd.hi("link", "MultiCursorDisabledVisual", "Visual")
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move to left split",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move to below split",
      },
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to above split",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move to right split",
      },
    },
  },
}
