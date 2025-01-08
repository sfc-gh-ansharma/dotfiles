-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "cpp",
      "bash",
      "git_config",
      "gitcommit",
      "json",
      "python",
      "ssh_config",
      "tmux",
    },
  },
}
