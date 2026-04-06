return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "esmuellert/codediff.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit" },
      { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Neogit push" },
      { "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Neogit pull" },
    },
  },
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    keys = {
      { "<leader>gd", "<cmd>CodeDiff<cr>", desc = "Diff working tree" },
      { "<leader>gdm", "<cmd>CodeDiff main...<cr>", desc = "Diff from main (PR view)" },
      { "<leader>gdh", "<cmd>CodeDiff HEAD~1<cr>", desc = "Diff last commit" },
    },
    opts = {},
  },
  {
    "fredeeb/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      { "<leader>gt", "<cmd>Tardis<cr>", desc = "Git time machine" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end

        -- Navigation
        map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First hunk")

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>hd", gs.diffthis, "Diff this")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff this ~")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    },
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" },
    },
    init = function() vim.g.undotree_WindowLayout = 3 end,
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = { headerMaxWidth = 80 },
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}
