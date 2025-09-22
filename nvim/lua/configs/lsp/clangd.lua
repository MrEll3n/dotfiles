return {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
  -- pozn.: clangd obslouží C, C++ i Objective-C. Není třeba zvlášť "c" a "cpp" server.
  init_options = {
    clangdFileStatus = true,
  },
  -- někomu pomáhá nastavit offsetEncoding kvůli některým pluginům:
  capabilities = { offsetEncoding = { "utf-16" } },
}

