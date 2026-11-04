# Runs on system zola (0.23.6+): the goyo submodule tracks the Tera 2
# migration (EstebanForge/goyo, branch tera-2, PR hahwul/goyo#222).
zola := env_var_or_default("ZOLA_BIN", "zola")

default:
    @just --list

build:
    {{ zola }} build

check:
    {{ zola }} check --skip-external-links

dev:
    {{ zola }} serve

clean:
    rm -rf public

# Build and publish public/ to the gh-pages branch (branch-based Pages, no Actions)
deploy:
    #!/usr/bin/env bash
    set -euo pipefail
    {{ zola }} build
    touch public/.nojekyll
    cd public
    git init -q -b gh-pages
    git add -A
    git commit -qm "Publish site build"
    git push -qf "$(git -C .. config remote.origin.url)" gh-pages
