local wezterm = require 'wezterm';
return {
    window_background_opacity = 0.85, -- 85% opaque
    -- color_scheme = "Dracula",
    -- colors = {
    --   background = "#0c0e14",
    -- },
    font_size = 10.0,
    -- dpi = 192.0,
    leader = {
        key = "b",
        mods = "CTRL"
    },

    default_prog = {"powershell.exe", "-NoLogo"},

    keys = {{
        key = "b",
        mods = "LEADER|CTRL",
        action = wezterm.action {
            SendString = "\x01"
        }
    }, {
        key = "r",
        mods = "LEADER",
        action = wezterm.action.PromptInputLine {
            description = "Rename Tab",
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end)
        }
    }, {
        key = "-",
        mods = "LEADER",
        action = wezterm.action {
            SplitVertical = {
                domain = "CurrentPaneDomain"
            }
        }
    }, {
        key = "+",
        mods = "LEADER",
        action = wezterm.action {
            SplitHorizontal = {
                domain = "CurrentPaneDomain"
            }
        }
    }, {
        key = "o",
        mods = "LEADER",
        action = "TogglePaneZoomState"
    }, {
        key = "z",
        mods = "LEADER",
        action = "TogglePaneZoomState"
    }, {
        key = "c",
        mods = "LEADER",
        action = wezterm.action {
            SpawnTab = "CurrentPaneDomain"
        }
    }, {
        key = "LeftArrow",
        mods = "LEADER",
        action = wezterm.action {
            ActivatePaneDirection = "Left"
        }
    }, {
        key = "DownArrow",
        mods = "LEADER",
        action = wezterm.action {
            ActivatePaneDirection = "Down"
        }
    }, {
        key = "UpArrow",
        mods = "LEADER",
        action = wezterm.action {
            ActivatePaneDirection = "Up"
        }
    }, {
        key = "RightArrow",
        mods = "LEADER",
        action = wezterm.action {
            ActivatePaneDirection = "Right"
        }
    }, {
        key = "H",
        mods = "LEADER|SHIFT",
        action = wezterm.action {
            AdjustPaneSize = {"Left", 5}
        }
    }, {
        key = "J",
        mods = "LEADER|SHIFT",
        action = wezterm.action {
            AdjustPaneSize = {"Down", 5}
        }
    }, {
        key = "K",
        mods = "LEADER|SHIFT",
        action = wezterm.action {
            AdjustPaneSize = {"Up", 5}
        }
    }, {
        key = "L",
        mods = "LEADER|SHIFT",
        action = wezterm.action {
            AdjustPaneSize = {"Right", 5}
        }
    }, {
        key = "&",
        mods = "LEADER",
        action = wezterm.action {
            ActivateTab = 0
        }
    }, {
        key = "é",
        mods = "LEADER",
        action = wezterm.action {
            ActivateTab = 1
        }
    }, {
        key = "\"",
        mods = "LEADER",
        action = wezterm.action {
            ActivateTab = 2
        }
    }, {
        key = "\'",
        mods = "LEADER",
        action = wezterm.action {
            ActivateTab = 3
        }
    }, {
        key = "(",
        mods = "LEADER",
        action = wezterm.action {
            ActivateTab = 4
        }
    }, {
        key = "§",
        mods = "LEADER",
        action = wezterm.action {
            ActivateTab = 5
        }
    }, {
        key = "è",
        mods = "LEADER",
        action = wezterm.action {
            ActivateTab = 6
        }
    }, {
        key = "!",
        mods = "LEADER",
        action = wezterm.action {
            ActivateTab = 7
        }
    }, {
        key = "ç",
        mods = "LEADER",
        action = wezterm.action {
            ActivateTab = 8
        }
    }, {
        key = "q",
        mods = "LEADER",
        action = wezterm.action {
            CloseCurrentTab = {
                confirm = true
            }
        }
    }, -- { key = "d", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
    {
        key = "x",
        mods = "LEADER",
        action = wezterm.action {
            CloseCurrentPane = {
                confirm = true
            }
        }
    }, {
        key = "t",
        mods = "LEADER",
        action = wezterm.action.SpawnTab("CurrentPaneDomain")
    }, {
        key = "n",
        mods = "LEADER",
        action = wezterm.action.ToggleFullScreen
    }, {
        key = "w",
        mods = "LEADER",
        action = wezterm.action.ShowTabNavigator
    }, -- {key="s", mods="LEADER", action=wezterm.action{PaneSelect={mode="SwapWithActive"}}},
    {
        key = "LeftArrow",
        mods = "SHIFT",
        action = wezterm.action.MoveTabRelative(-1)
    }, {
        key = "RightArrow",
        mods = "SHIFT",
        action = wezterm.action.MoveTabRelative(1)
    } -- (your other key bindings)
    }
}
