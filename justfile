_default:
    @just --list

check:
    shellcheck --shell=sh --color=always ./*.sh

format:
    shfmt --list --write --posix --indent 4 .
