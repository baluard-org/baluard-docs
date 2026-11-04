# Zola 0.22 is pinned: the Goyo theme predates the Tera v2 migration in
# Zola 0.23 and does not build on it yet. Lift this pin when goyo ships
# a Tera 2 release. https://github.com/hahwul/goyo
zola := env_var_or_default("ZOLA_BIN", env("HOME") / "Apps" / "zola-0.22" / "zola")

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
