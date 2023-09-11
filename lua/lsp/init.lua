local servers = {
	"ansiblels",
	"bashls",
	"eslint",
	"html",
	"jdtls",
	"jsonls",
	"lemminx",
	"lua_ls",
	"marksman",
	"tsserver",
	"volar",
	"yamlls",
}

local mason_status, mason = pcall(require, "mason")

if not mason_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")

if not mason_lspconfig_status then
	return
end

local lspconfig_status, lspconfig = pcall(require, "lspconfig")

if not lspconfig_status then
	return
end

local lsp_keymaps = function(bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, bufopts)
	-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
	-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set("n", "<Leader>wl", function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<Leader>f", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<Leader>=", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

local hover_instance = function(client)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", {})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = 0,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = 0,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- if client.name == "eslint" then
	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		buffer = bufnr,
	-- 		command = "EslintFixAll",
	-- 	})
	-- end
	--
	-- -- format all buffer
	-- vim.api.nvim_create_autocmd("BufWritePre", {
	-- 	buffer = bufnr,
	-- 	callback = function()
	-- 		vim.lsp.buf.format({ async = false })
	-- 	end,
	-- })

	lsp_keymaps(bufnr)

	hover_instance(client)

	-- disable semantic token
	client.server_capabilities.semanticTokensProvider = nil
end

mason.setup({
	ui = {
		border = "rounded",
	},
})

mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

vim.diagnostic.config({
	virtual_text = false, -- disable virtual text
	signs = {
		severity_limit = "Hint",
		active = signs, -- show signs
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)

	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	-- For jdtls to work we need java 17+ and JAV_HOME set correctly in .bashrc
	-- i.e. export JAVA_HOME=/usr/lib/jvm/java-19-openjdk-amd64

	lspconfig[server].setup(opts)
end
