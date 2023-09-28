local status_status, autopairs = pcall(require, "nvim-autopairs")

if not status_status then
	return
end

autopairs.setup({
	check_ts = true,
	ts_config = {
		javascript = { "template_string" },
	},
})
