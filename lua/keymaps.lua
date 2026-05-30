vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }

		-- Global Safe Rename (PyCharm style)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		-- Find All References & Definitions (Hooks seamlessly into Telescope)
		local has_telescope, telescope = pcall(require, "telescope.builtin")
		if has_telescope then
			vim.keymap.set("n", "gr", telescope.lsp_references, opts)
			vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
		else
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		end
	end,
})
-- Toggle git gutter indicators on/off cleanly via Lua API
vim.keymap.set("n", "<leader>gs", function()
  require("gitsigns").toggle_signs()
end, { desc = "Toggle Git Signs Gutter" })


-- Toggle the structural code outline sidebar on and off
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>", { desc = "Toggle Code Outline" })
local dap = require("dap")
local dapui = require("dapui")

-------------------------------------------------------------------------------
-- AUTOMATIC STRUCTURAL HOOKS (UI Lifecycle Management)
-------------------------------------------------------------------------------
-- Automatically open panels when execution drops into initialization states
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- Automatically collapse panel states when routines conclude or are killed
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-------------------------------------------------------------------------------
-- STEPPING CONTROLS & DESCRIPTIONS
-------------------------------------------------------------------------------
-- F5 starts operations or skips onward to the next active breakpoint boundary
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })

-- F10 steps completely over current expressions without stepping downward into child routines
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })

-- F11 descends your cursor context downward directly into internal function definitions
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })

-- F12 breaks out of sub-routines back up to the calling scope level
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

-- Leader b attaches/detaches a structural breakpoint on your active cursor line
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
