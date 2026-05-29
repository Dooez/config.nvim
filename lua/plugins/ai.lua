return {
	{
		"carlos-algms/agentic.nvim",

		opts = {
			-- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp"
			provider = "kilo", -- setting the name here is all you need to get started
			acp_providers = {
				["kilo"] = {
					name = "Kilo",
					command = "kilo",
					args = { "acp" },
					env = {
						YADRO_JIRA_TOKEN       = os.getenv("YADRO_JIRA_TOKEN"),
						YADRO_CONFLUENCE_TOKEN = os.getenv("YADRO_CONFLUENCE_TOKEN"),
						YADRO_OPENAI_KEY       = os.getenv("YADRO_OPENAI_KEY"),
					},
				},
			},
			diff_preview = {
				enabled = true,
				layout = "inline", -- "split" or "inline"
				center_on_navigate_hunks = true,
			},
		},
		-- these are just suggested keymaps; customize as desired
		keys = {
			{
				"<leader>at",
				function() require("agentic").toggle() end,
				mode = { "n", "v", },
				desc = "Toggle Agentic Chat"
			},
			{
				"<leader>a'",
				function() require("agentic").add_selection_or_file_to_context() end,
				mode = { "n", "v" },
				desc = "Add file or selection to Agentic to Context"
			},
			{
				"<leader>as",
				function() require("agentic").stop_generation() end,
				mode = { "n", "v" },
				desc = "Stop Agentic generation"
			},
			{
				"<leader>an",
				function() require("agentic").new_session() end,
				mode = { "n", "v", },
				desc = "New Agentic Session"
			},
			{
				"<leader>ar", -- ai Restore
				function()
					require("agentic").restore_session()
				end,
				desc = "Agentic Restore session",
				silent = true,
				mode = { "n", "v" },
			},
			{
				"<leader>ad", -- ai Diagnostics
				function()
					require("agentic").add_current_line_diagnostics()
				end,
				desc = "Add current line diagnostic to Agentic",
				mode = { "n" },
			},
			{
				"<leader>aD", -- ai all Diagnostics
				function()
					require("agentic").add_buffer_diagnostics()
				end,
				desc = "Add all buffer diagnostics to Agentic",
				mode = { "n" },
			},
		},
	}

}
