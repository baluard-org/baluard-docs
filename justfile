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
