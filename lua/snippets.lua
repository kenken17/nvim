local ls = require("luasnip")
-- local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep
local snip = ls.snippet
-- local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node

local filename = function()
	return vim.fn.expand("%:t")
end

ls.config.setup({})

local con = snip("con", {
	text("console.log('\\n =================== "),
	func(filename),
	-- func(copy, 1),
	text(" \\n', "),
	insert(1),
	text(", '\\n ===================\\n') // >>> TO_REMOVE"),
})

ls.add_snippets(nil, {
	javascript = {
		con,
	},
	vue = {
		con,
	},
})
