return {
  -- Metadata
  name = "nightfox",
  author = "EdenEast",
  origin_url = "https://github.com/EdenEast/nightfox.nvim",

  -- Colors
  colors = {
    foreground = "#cdcecf",
    background = "#192330",
    cursor_bg = "#cdcecf",
    cursor_border = "#cdcecf",
    cursor_fg = "#192330",
    compose_cursor = "#f4a261",
    selection_bg = "#2b3b51",
    selection_fg = "#cdcecf",
    scrollbar_thumb = "#71839b",
    split = "#131a24",
    visual_bell = "#cdcecf",
    ansi = {"#393b44", "#c94f6d", "#81b29a", "#dbc074", "#719cd6", "#9d79d6", "#63cdcf", "#dfdfe0"},
    brights = {"#575860", "#d16983", "#8ebaa4", "#e0c989", "#86abdc", "#baa1e2", "#7ad5d6", "#e4e4e5"},
    indexed = {
      [16] = "#d67ad2",
      [17] = "#f4a261",
    },

    -- Tab Bar Colors
    tab_bar = {
      background = "#131a24",
      inactive_tab_edge = "#131a24",
      inactive_tab_edge_hover = "#212e3f",

      -- Active tab
      active_tab = {
        bg_color = "#71839b",
        fg_color = "#192330",
        intensity = "Normal",
        italic = false,
        strikethrough = false,
        underline = "None",
      },

      -- Inactive tab
      inactive_tab = {
        bg_color = "#212e3f",
        fg_color = "#aeafb0",
        intensity = "Normal",
        italic = false,
        strikethrough = false,
        underline = "None",
      },

      -- Inactive tab hover
      inactive_tab_hover = {
        bg_color = "#29394f",
        fg_color = "#cdcecf",
        intensity = "Normal",
        italic = false,
        strikethrough = false,
        underline = "None",
      },

      -- New tab
      new_tab = {
        bg_color = "#192330",
        fg_color = "#aeafb0",
        intensity = "Normal",
        italic = false,
        strikethrough = false,
        underline = "None",
      },

      -- New tab hover
      new_tab_hover = {
        bg_color = "#29394f",
        fg_color = "#cdcecf",
        intensity = "Normal",
        italic = false,
        strikethrough = false,
        underline = "None",
      },
    },
  },
}
