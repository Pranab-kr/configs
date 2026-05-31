local M = {}

local groups = {
	"NormalFloat",
	"FloatBorder",
	"FloatTitle",
	"LazyNormal",
	"LazyBorder",
	"LazyBackdrop",
	"MasonNormal",
	"MasonBackdrop",
	"WhichKeyFloat",
	"WhichKeyNormal",
	"WhichKeyBorder",
	"MiniFilesNormal",
	"MiniFilesBorder",
	"MiniNotifyNormal",
	"MiniNotifyBorder",
	"MiniPickNormal",
	"MiniPickBorder",
	"SnacksNormal",
	"SnacksNormalNC",
	"SnacksTitle",
	"SnacksFooter",
	"SnacksBorder",
	"SnacksBackdrop",
	"NoicePopup",
	"NoicePopupBorder",
	"NoiceCmdlinePopup",
	"NoiceCmdlinePopupBorder",
	"SnacksDashboardNormal",
	"SnacksInputNormal",
	"SnacksInputBorder",
	"SnacksNotifierMinimal",
	"SnacksPickerPickWin",
	"SnacksPickerInput",
	"SnacksPickerList",
	"SnacksPickerPreview",
}

function M.apply()
	for _, group in ipairs(groups) do
		if vim.fn.hlexists(group) == 1 then
			local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
			hl.bg = nil
			hl.ctermbg = nil
			vim.api.nvim_set_hl(0, group, hl)
		end
	end
end

function M.setup()
	M.apply()

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("pranab-transparency", { clear = true }),
		callback = M.apply,
	})
end

return M
