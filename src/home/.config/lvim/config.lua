-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
--

lvim.plugins = {  
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({style='warmer'})
    end,
  },
  {
    "nvim-telscope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    config = true
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {

    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    }
  },
--  {
--   "David-Kunz/gen.nvim",
--    opts = {
--      model = "codellama:latest",
--      quit_map = "q",
--      retry_map = "<c-r>", -- set keymap to re-send the current prompt
--      accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
--      host = "localhost", -- The host running the Ollama service.
--      port = "11434", -- The port on which the Ollama service is listening.
--      display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
--      show_prompt = false, -- Shows the prompt submitted to Ollama.
--      show_model = false, -- Displays which model you are using at the beginning of your chat session.
--      no_auto_close = false, -- Never closes the window automatically.
--      file = false, -- Write the payload to a temporary file to keep the command short.
--      hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
--      init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
      -- Function to initialize Ollama
--      command = function(options)
--          local body = {model = options.model, stream = true}
--          return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
--      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
--      debug = false -- Prints errors and the command which is run.
--    }
--  }
}


local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<c-s>", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)

lvim.colorscheme = "onedark"
vim.opt.autoread = false

-- init.lua
local neogit = require("neogit")

neogit.setup { }

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
