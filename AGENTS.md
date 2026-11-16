# baluard-docs AGENTS.md

Docs site for Baluard, public at https://docs.baluard.app. Zola, deployed by GitHub Pages on every push to main.

## OVERVIEW

- Stack: Zola (system binary, `just` recipes), goyo theme as a submodule, Tailwind-free plain markdown content.
- Content lives in `content/`: `introduction/` (grouped into `install/`, `sync/`, `vault/` subsections) and `shared-spaces/`.
- Every article has an English page and a Spanish twin (`<name>.md` + `<name>.es.md`). Never add one without the other.
- Section landing pages (`_index.md`) are short: a few sentences and a numbered child list. Never move a full article's body into a landing page; children hang off short landings only.

## COMMANDS

| Action | Command |
|--------|---------|
| Check internal links and orphans | `just check` |
| Build the site | `just build` |
| Local preview | `just dev` |

## STANDING RULES

- **Local CI: always build before you push.** Pages deploys whatever lands on main, so the pushed tree must already be compiled and verified here. Run `just check` and `just build` and confirm both are green before every commit and push. Never push and wait for CI to find out.
- **Moved pages keep their URLs.** When relocating an article, add a Zola `aliases = ["old/path"]` entry so the old address serves a redirect; the support site links into these pages.
- **Internal links use `@/` paths.** After moving anything, sweep `rg "@/introduction/"` for stale references across all content, including the `.es.md` twins.
- Keep the user voice of the articles: plain language, no marketing, honest about known gaps. The user runs commands; the docs print them.
