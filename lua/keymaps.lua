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
