local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

-- If you're reading this file for the first time, best skip to around line 190
-- where the actual snippet-definitions start.

-- Every unspecified option will be set to the default.
ls.setup({
	history = true,
	-- Update more often, :h events for more info.
	update_events = "TextChanged,TextChangedI",
	-- Snippets aren't automatically removed if their text is deleted.
	-- `delete_check_events` determines on which events (:h events) a check for
	-- deleted snippets is performed.
	-- This can be especially useful when `history` is enabled.
	delete_check_events = "TextChanged",
})

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
	return args[1]
end

require("luasnip.loaders.from_vscode").load()

-- All snippets 
ls.add_snippets("all", {
})

ls.add_snippets("tex", {
    s("beg", {
        -- add text 
        t("\\begin{"),
        -- Get text 
        i(1),
        -- add text make new line
        t({"}", "\t"}),
        -- where the cursor will finish
        i(0),
        -- more freaking text 
        t({"","\\end{"}),
        -- add the already inserted variable also here
        f(copy, 1),
        -- more text 
        t("}")
    })
})

-- Works good (don't change)
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true})

vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true})


vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.choice_active(-1) then
        ls.choice_choice(-1)
    end
end, { silent = true})

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/luaConfigs/luaSnip.lua<CR>")
