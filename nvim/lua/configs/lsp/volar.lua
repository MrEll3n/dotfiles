-- Vue LSP (Volar) v "Take Over" režimu: pokrývá i TS/JS soubory v monorepech s Vue
return {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
  -- Volar preferuje lokální "typescript" v projektu (node_modules). Pokud není, pojede i tak.
  -- init_options = {
  --   typescript = { tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib" },
  -- },
}

