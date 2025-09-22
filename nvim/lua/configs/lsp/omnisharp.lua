-- C# přes Omnisharp (mason balík "omnisharp")
return function(nvlsp)
  local opts = {
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
  }

  -- Některé buildy Omnisharpu neposílají semantic tokens -> jednoduchý patch v on_attach
  local function patch_semantic_tokens(client)
    if not client.server_capabilities.semanticTokensProvider then
      local caps = client.config.capabilities
      if caps and caps.textDocument and caps.textDocument.semanticTokens then
        client.server_capabilities.semanticTokensProvider = {
          full = true,
          legend = {
            tokenModifiers = caps.textDocument.semanticTokens.tokenModifiers,
            tokenTypes = caps.textDocument.semanticTokens.tokenTypes,
          },
          range = true,
        }
      end
    end
  end

  opts.on_attach = function(client, bufnr)
    patch_semantic_tokens(client)
    -- přiklapí se i NvChad on_attach (viz loader)
  end

  return opts
end

