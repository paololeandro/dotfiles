config.load_autoconfig(False)

#config.set("fileselect.handler", "external")
#config.set("fileselect.single_file.command", ['foot', '--class', 'ranger,ranger', '-e', 'ranger', '--choosefile', '{}'])
#config.set("fileselect.multiple_files.command", ['foot', '--class', 'ranger,ranger', '-e', 'ranger', '--choosefiles', '{}'])

config.bind('xs', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xx', 'config-cycle tabs.show always never;; config-cycle statusbar.show always never')

# c.url.start_pages = ["qute://bookmarks/"]
c.url.start_pages = ["https://start.duckduckgo.com/"]

c.fonts.default_family = "Iosevka Nerd Font"
c.fonts.default_size = '12pt'

c.fonts.completion.entry = '12pt "Iosevka Nerd Font"'
c.fonts.debug_console = '12pt "Iosevka Nerd Font"'
c.fonts.prompts = '12pt "Iosevka Nerd Font"'
c.fonts.statusbar = '12pt "Iosevka Nerd Font"'

c.colors.completion.fg = '#D7D7D7'
c.colors.completion.odd.bg = '#272727'
c.colors.completion.even.bg = '#272727'
c.colors.completion.category.fg = '#ffffff'
c.colors.completion.category.bg = '#272727'
c.colors.completion.item.selected.bg = '#D7D7D7'
c.colors.completion.item.selected.fg = '#272727'
c.colors.completion.item.selected.border.bottom = '#D7D7D7'
c.colors.completion.item.selected.border.top = '#D7D7D7'
c.colors.hints.fg = '#f4bf75'
c.colors.hints.bg = '#272727'
c.colors.hints.match.fg = '#000000'
c.colors.messages.info.bg = '#272727'
c.colors.statusbar.normal.bg = '#272727'
c.colors.statusbar.insert.fg = '#6a89a2'
c.colors.statusbar.insert.bg = '#272727'
c.colors.statusbar.passthrough.bg = '#56B6C2'
c.colors.statusbar.command.bg = '#272727'
c.colors.statusbar.url.warn.fg = '#6a9fb5'
c.colors.tabs.bar.bg = '#272727'
c.colors.tabs.odd.bg = '#202020'
c.colors.tabs.even.bg = '#202020'
c.colors.tabs.selected.odd.bg = '#272727'
c.colors.tabs.selected.even.bg = '#272727'
c.colors.tabs.pinned.odd.bg = '#272727'
c.colors.tabs.pinned.even.bg = '#272727'
c.colors.tabs.pinned.selected.odd.bg = '#272727'
c.colors.tabs.pinned.selected.even.bg = '#272727'
