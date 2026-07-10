vim.filetype.add({
    extension = {
        c = "c",
        h = "c",
        cpp = "cpp",
        hpp = "cpp",
        cc = "cpp",
        lua = "lua",
        sh = "sh",
        bash = "sh",
        tex = "tex",
        m = "octave",
    },
    filename = {
        ["CMakeLists.txt"] = "cmake",
        ["Makefile"] = "make",
    },
})

vim.lsp.enable({"lua_ls", "neocmake", "clangd"})
