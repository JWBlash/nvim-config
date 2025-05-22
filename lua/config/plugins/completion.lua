return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = { preset = 'default' },
      -- there's an open bug where cmdline completion under wsl (maybe not JUST
      -- wsl, but that's how I am seeing the behavior) is extremely slow and
      -- causes nvim to totally freeze for awhile. So disable blink.cmp here
      cmdline = { enabled = false },

      appearance = {
        nerd_font_variant = 'mono'
      },
    },
  },
}
