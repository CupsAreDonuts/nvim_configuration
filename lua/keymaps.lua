vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = "Go to project root." })

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
