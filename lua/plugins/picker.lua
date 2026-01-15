return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        config = function(_, opts)
            local fzf = require('fzf-lua')
            fzf.setup(opts)
            vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch [G]rep', })
            vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sw', fzf.lsp_live_workspace_symbols, { desc = '[S]earch [W]orkspace Symbols' })
            vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume', })
            vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = '[G]o [D]definition', })
            vim.keymap.set('n', 'gD', fzf.lsp_declarations, { desc = '[G]o [D]eclaration', })
            vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = '[G]o [R]eferences', })
        end,
    }
}
