---@module "blink-cmp"
return {
  'saghen/blink.cmp',
  version = '1.*',
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'none',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },

      ['<Tab>'] = {
        function(cmp)
          if cmp.is_menu_visible() then return cmp.select_next() end
        end,
        'snippet_forward',
        'fallback',
      },
      ['<S-Tab>'] = {
        function(cmp)
          if cmp.is_menu_visible() then return cmp.select_prev() end
        end,
        'snippet_backward',
        'fallback',
      },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-n>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    completion = {
      list = { selection = { preselect = false } },
      documentation = { auto_show = true, auto_show_delay_ms = 0, update_delay_ms = 50 },
    },
    signature = { enabled = true },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
  },
}
