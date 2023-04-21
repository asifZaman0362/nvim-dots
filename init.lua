local o = vim.o
local w = vim.wo
local b = vim.bo
local set = vim.opt

local utils = require('utils')

vim.g.mapleader = ' '

set.autoindent = true
set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4
set.modeline = false

w.number = true
w.relativenumber = true
w.cursorline = true
w.list = true
w.wrap = false

o.lazyredraw = true
o.splitbelow = true
o.splitright = true

o.mouse = 'a'

--local plugins = require('plugins')
local plugins = require('plugin')
require('plugin_config')
vim.o.background = "dark"

-- Key bindings
utils.map('n', "<Leader>t", ":NvimTreeToggle <CR>", { noremap = true })
utils.map('n', "<Leader>h", ":noh<CR>", { noremap = true })
utils.map('n', "<Leader>ff", ":Telescope git_files<CR>", { noremap = true })
utils.map('n', "<Leader>fg", ":Telescope find_files<CR>", { noremap = true })
utils.map('n', "<Leader>fh", ":Telescope live_grep<CR>", { noremap = true })
utils.map('n', "<Leader>fb", ":Telescope buffers<CR>", { noremap = true })
utils.map('n', "<Leader>fh", ":Telescope help_tags<CR>", { noremap = true })
utils.map('n', "<Leader>F", ":! rustfmt %<CR>", { noremap = true })
utils.map('n', "<Leader>s", ":vsplit<CR>", { noremap = true });
utils.map('n', "<Leader>S", ":split<CR>", { noremap = true });
utils.map('n', "<Leader>R", ":CargoReload<CR>", { noremap = true });
utils.map('n', "<Leader>ga", ":!git add -A<CR><CR>", { noremap = true });

-- dap configuration
utils.map('n', "<Leader>dd", ":lua require'dapui'.toggle()<CR>", { noremap = true });
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)
-- dap

-- lsp configuration
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
-- Rust


-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.cmd [[autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab]]
vim.cmd [[autocmd FileType javascriptreact setlocal shiftwidth=2 softtabstop=2 expandtab]]
vim.cmd [[autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab]]
vim.cmd [[autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab]]
vim.cmd [[autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 expandtab]]

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Completion Plugin Setup

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspAttach_inlayhints",
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require("lsp-inlayhints").on_attach(client, bufnr)
    end,
})
vim.cmd([[highlight! link LspInlayHint Comment]])
vim.cmd([[colorscheme tokyonight-night]])
vim.opt.foldmethod = "syntax"
vim.diagnostic.config({ virtual_text = true })
