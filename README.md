# ArabuLang + Arabuscador

Interface web simples para explorar e editar arquivos do ArabuLang, com um navegador (Arabuscador) e um editor (ArabuLang). Inclui suporte a abas, modo escuro e navegação integrada entre as páginas.

## Visão Geral

- `arabuscador.html`: Navegador de páginas/arquivos `.arbl` com UI amigável.
- `arabulang.html`: Editor/ambiente do ArabuLang com botão “navegador” para voltar ao browser.
- `serve.ps1`: Servidor HTTP em PowerShell para rodar localmente no Windows.

## Recursos Principais

- Modo escuro com persistência (botão “🌙” no topo alterna entre claro/escuro e salva a preferência).
- Abas no navegador:
  - “+” cria uma nova aba e volta para a Página Inicial.
  - Título da aba atualiza para o nome do arquivo `.arbl` carregado e para “Editor” quando o editor é aberto.
  - Abas podem ser fechadas; ao fechar a aba ativa, volta para a primeira aba (Home).
- Navegação integrada:
  - “Editor” e “✏️ Editar no ArabuLang” em `arabuscador.html` levam para `arabulang.html` na mesma guia.
  - Botão “navegador” em `arabulang.html` volta para `arabuscador.html`.

## Como Executar Localmente (Windows)

- Inicie o servidor (porta 8080) na pasta atual:
```bash
powershell -ExecutionPolicy Bypass -File serve.ps1 -Port 8080 -Root .
```

- Acesse no navegador:
  - `http://localhost:8080/arabuscador.html`
  - Opcional: `http://localhost:8080/arabulang.html`

- Você também pode usar outra porta, por exemplo 8082:
```bash
powershell -ExecutionPolicy Bypass -File serve.ps1 -Port 8082 -Root .
```

## Páginas Principais

- `arabuscador.html`
  - Botões:
    - “Editor” e “✏️ Editar no ArabuLang”: abrem o editor `arabulang.html`.
    - “Ver código”: abre o editor embutido do navegador.
    - “🌙”: alterna tema claro/escuro e salva a escolha.
  - Abas:
    - “+” para nova aba; fecha com “✕”; títulos atualizados conforme conteúdo.
  - “Página Inicial”: estado limpo da UI.

- `arabulang.html`
  - Botão “navegador”: retorna para `arabuscador.html`.
  - Área de edição/execução do ArabuLang.

## Estrutura do Projeto
