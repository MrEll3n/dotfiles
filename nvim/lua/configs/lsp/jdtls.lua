-- Minimální JDT. Pro pokročilé features (code actions, testy, debug) doporučuji plugin "nvim-jdtls".
return {
  -- mason-lspconfig nastaví cmd/root_dir automaticky
  on_attach = function(client, bufnr)
    -- sem si můžeš dát Java-specifické mapy; NvChad on_attach se už přiklapí v loaderu
  end,
}

