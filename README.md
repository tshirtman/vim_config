Vim configuration layout

- `vimrc`: Minimal entrypoint that sets core flags and loads plugins.
- `plugin/00-settings.vim`: Core editor options and defaults.
- `plugin/01-keymaps.vim`: General, non‑plugin keymaps.
- `plugin/02-autocmds.vim`: Autocommands (cursorline, terminals, dev helpers).
- `plugin/20-theme.vim`: Colorscheme + highlight tweaks.
- `plugin/ui.vim`: Small UI helpers (e.g., signcolumn toggle).
- `plugin/*-config.vim`: Plugin‑specific options and keymaps.
- `after/plugin/airline.vim`: Airline theme patching after plugin load.

Plugins are declared in `plugin/plug-list.vim` (vim‑plug). Add per‑plugin
settings/mappings to a `plugin/<name>-config.vim` file to keep `vimrc` clean.
