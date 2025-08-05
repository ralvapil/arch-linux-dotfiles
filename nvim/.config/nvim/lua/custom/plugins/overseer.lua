return {
  'stevearc/overseer.nvim',
  opts = {},
  config = function()
    local overseer = require 'overseer'
    overseer.setup()

    -- Keybinds for common use
    vim.keymap.set('n', '<leader>tt', '<cmd>OverseerToggle<CR>', { desc = 'Toggle task list' })
    vim.keymap.set('n', '<leader>tr', '<cmd>OverseerRun<CR>', { desc = 'Run task' })
    vim.keymap.set('n', '<leader>ta', '<cmd>OverseerQuickAction<CR>', { desc = 'Quick task actions' })
    vim.keymap.set('n', '<leader>tc', '<cmd>OverseerClearCache<CR>', { desc = 'Clear task cache' })

    -- Optional: run `cargo build` in a Rust project
    vim.keymap.set('n', '<leader>rb', function()
      overseer.run_template { name = 'cargo build' }
    end, { desc = 'Cargo build' })

    vim.keymap.set('n', '<leader>rc', function()
      overseer.run_template { name = 'cargo run' }
    end, { desc = 'Cargo run' })

    vim.keymap.set('n', '<leader>rt', function()
      overseer.run_template { name = 'cargo test' }
    end, { desc = 'Cargo test' })
  end,
}
