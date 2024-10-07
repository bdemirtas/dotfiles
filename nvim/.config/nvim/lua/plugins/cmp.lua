return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    --Autocompletion
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "saadparwaiz1/cmp_luasnip",
    "lukas-reineke/cmp-under-comparator",
    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    -- UI
    "onsails/lspkind.nvim",
  },
  config = function()
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"
    require("luasnip.loaders.from_lua").lazy_load()
    -- Set this check up for nvim-cmp tab mapping
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end
    local cmp = require "cmp"
    require("luasnip.loaders.from_vscode").lazy_load()
    local options = {
      completion = {
        keyword_length = 3,
      },
      vuew = {
        docs = {
          auto_open = false,
        },
      },
      formatting = {
        format = lspkind.cmp_format {
          before = function(_entry, vim_item)
            if vim_item.menu ~= nil and string.len(vim_item.menu) > 0 then
              vim_item.menu = string.sub(vim_item.menu, 1, 0) .. ""
            end
            return vim_item
          end,
          mode = "symbol_text",
          symbol_map = {
            Text = "て",
            Method = "Ⲙ",
            Class = "Ⲥ",
            Module = "",
            File = "", -- 
            Reference = "",
          },

          menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            vsnip = "[snip]",
          },
        },
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = {
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
      },
    }
    options = vim.tbl_deep_extend("force", options, require "nvchad.cmp")
    cmp.setup(options)
  end,
}
