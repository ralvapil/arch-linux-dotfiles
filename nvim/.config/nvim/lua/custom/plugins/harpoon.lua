return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- Telescope integration
    local function toggle_telescope(list)
      local conf = require('telescope.config').values
      local file_paths = {}

      for _, item in ipairs(list.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    -- <leader>h to open Harpoon Telescope view
    vim.keymap.set('n', '<leader>h', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open Harpoon Telescope window' })

    -- Add file to Harpoon list
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add file to Harpoon' })

    -- Clear Harpoon list
    vim.keymap.set('n', '<leader>hc', function()
      harpoon:list():clear()
    end, { desc = 'Clear Harpoon list' })

    -- Ctrl+h/j/k/l to select 1–4
    vim.keymap.set('n', '<C-h>', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon file 1' })
    vim.keymap.set('n', '<C-j>', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon file 2' })
    vim.keymap.set('n', '<C-k>', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon file 3' })
    vim.keymap.set('n', '<C-l>', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon file 4' })
  end,
}
