return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = "make BUILD_FROM_SOURCE=true",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	---@module 'avante'
	---@type avante.Config
	opts = {
		-- add any opts here
		-- this file can contain specific instructions for your project
		instructions_file = "avante.md",
		-- for example
		provider = "kilo",
		providers = {
			openai = {
				endpoint = "https://litellm-proxy.ai.yadro.com/",
				model = "Qwen3-Coder-30B-A3B-Instruct-FP8",
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					temperature = 0.75,
					-- max_tokens = 20480,
				},
			},
		},
		acp_providers = {
			["kilo"] = {
				command = "kilo",
				args = { "acp" },
				env = {
					NODE_NO_WARNINGS       = "1",
					YADRO_JIRA_TOKEN       = os.getenv("YADRO_JIRA_TOKEN"),
					YADRO_CONFLUENCE_TOKEN = os.getenv("YADRO_CONFLUENCE_TOKEN"),
					YADRO_OPENAI_KEY       = os.getenv("YADRO_OPENAI_KEY"),
				}
			}
		},
		behaviour = {
			enable_fastapply = false,
			auto_apply_diff_after_generation = false,
			auto_approve_tool_permissions = true,
			confirmation_ui_style = "pupup",
		}
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		-- "nvim-mini/mini.pick", -- for file_selector provider mini.pick
		-- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		-- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		-- "stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		-- "zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			'MeanderingProgrammer/render-markdown.nvim',
			opts = {
				file_types = { "Avante" },
			},
			ft = { "Avante" },
		},
	},
	{
		"folke/sidekick.nvim",
		opts = {
			nes = { enabled = false },
			cli = {
				tools = {
					kilo = {
						cmd = { "bash", "-c", "kilo 2>/dev/null" },
						is_proc = "\\<kilo\\>",
						keys = {
							prompt = { "<a-p>", "prompt" }
						},
					}
				}
			}
		},
		keys = {
			{
				"<c-.>",
				function() require("sidekick.cli").focus() end,
				desc = "Sidekick Focus",
				mode = { "n", "t", "i", "x" },
			},
			{
				"<leader>aa",
				function() require("sidekick.cli").toggle() end,
				desc = "Sidekick Toggle CLI",
			},
			{
				"<leader>as",
				function() require("sidekick.cli").select() end,
				-- Or to select only installed tools:
				-- require("sidekick.cli").select({ filter = { installed = true } })
				desc = "Select CLI",
			},
			{
				"<leader>at",
				function() require("sidekick.cli").send({ msg = "{this}" }) end,
				mode = { "x", "n" },
				desc = "Send This",
			},
			{
				"<leader>af",
				function() require("sidekick.cli").send({ msg = "{file}" }) end,
				desc = "Send File",
			},
			{
				"<leader>av",
				function() require("sidekick.cli").send({ msg = "{selection}" }) end,
				mode = { "x" },
				desc = "Send Visual Selection",
			},
			{
				"<leader>ap",
				function() require("sidekick.cli").prompt() end,
				mode = { "n", "x" },
				desc = "Sidekick Select Prompt",
			},
			{
				"<leader>ak",
				function() require("sidekick.cli").toggle({ name = "kilo", focus = true }) end,
				desc = "Sidekick Toggle Kilo",
			},
		},
		dependencies = {
			{
				"folke/snacks.nvim",
				optional = true,
				opts = {
					picker = {
						actions = {
							sidekick_send = function(...)
								return require("sidekick.cli.picker.snacks").send(...)
							end,
						},
						win = {
							input = {
								keys = {
									["<a-a>"] = {
										"sidekick_send",
										mode = { "n", "i" },
									},
								},
							},
						},
					},
				},
			}
		}
	}
}
