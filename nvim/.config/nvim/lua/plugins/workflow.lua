return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Débogage : continuer",
			},
			{
				"<F9>",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Point d’arrêt",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Débogage : passer",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Débogage : entrer",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Débogage : sortir",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Interface de débogage",
			},
			{
				"<leader>dq",
				function()
					require("dap").terminate()
				end,
				desc = "Arrêter le débogage",
			},
		},
		config = function()
			local dap, ui = require("dap"), require("dapui")
			ui.setup()
			dap.adapters.lldb = { type = "executable", command = "lldb-dap", name = "lldb" }
			for _, language in ipairs({ "c", "cpp", "rust" }) do
				dap.configurations[language] = {
					{
						name = "Exécutable local (compiler avec -g)",
						type = "lldb",
						request = "launch",
						program = function()
							return vim.fn.input("Exécutable : ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
						stopOnEntry = false,
					},
				}
			end
			dap.listeners.after.event_initialized["dotfiles_ui"] = function()
				ui.open()
			end
			dap.listeners.before.event_terminated["dotfiles_ui"] = function()
				ui.close()
			end
			dap.listeners.before.event_exited["dotfiles_ui"] = function()
				ui.close()
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>lf",
				function()
					if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then
						vim.notify("C/42 : utiliser F2 pour le formateur existant.", vim.log.levels.INFO)
						return
					end
					require("conform").format({ async = true, lsp_format = "never" })
				end,
				desc = "Formater (Conform)",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				sh = { "shfmt" },
				bash = { "shfmt" },
			},
			-- Formatting remains explicit; F2 and Norminette keep handling C/42.
			default_format_opts = { lsp_format = "never" },
		},
	},
	{
		"stevearc/overseer.nvim",
		cmd = { "OverseerRun", "OverseerToggle", "OverseerBuild", "OverseerQuickAction" },
		opts = {},
		keys = {
			{ "<leader>or", "<cmd>OverseerRun<CR>", desc = "Lancer une tâche" },
			{ "<leader>ot", "<cmd>OverseerToggle<CR>", desc = "Afficher les tâches" },
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
		},
		keys = {
			{
				"<leader>ut",
				function()
					require("neotest").run.run()
				end,
				desc = "Test le plus proche",
			},
			{
				"<leader>uf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Tester le fichier",
			},
			{
				"<leader>us",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Résultats des tests",
			},
			{
				"<leader>uo",
				function()
					require("neotest").output.open({ enter = true })
				end,
				desc = "Sortie du test",
			},
		},
		opts = function()
			return { adapters = { require("neotest-python")({ runner = "pytest" }) } }
		end,
	},
}
