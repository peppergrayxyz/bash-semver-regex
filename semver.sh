#!/usr/bin/env sh

semver() {
    # shellcheck disable=SC2034
    v="$1" major="" minor="" patch="" prerelease="" buildmetadata=""

    D='[0-9]' 
    W='[0-9a-zA-Z-]'
    # semver digit
    SD="[1-9]$D*"
    # pre-release word
    PW="$D*[a-zA-Z-]$W*"
    # build-metadata word
    MW="$W$W*"

    # match pattern
    re() { x="$2"; w="$v"; while [ -n "$x" ]; do p="$x"
    case "$p" in *"]*"*) p="${p%"${p#*"*"}"}"    ;; esac
    case "$p" in *"]["*) p="${p%"${p#*"]"}"}"    ;; esac; x="${x#"$p"}"; q="1";
    case "$p" in *"*") q=${p#"${p%?}"}; p=${p%?} ;; esac;
    while true; do s=""; case "$v" in $p*) s="${v%"${v#?}"}"; v="${v#?}"; [ -n "$1" ] && eval "$1+=\"$s\"" ;; esac            
    [ "$q" = "1" ] && [ -z "$s" ] && v="$w" && return 1; [ "$q" = "1" ] && break; [ -z "$s" ] && break; done done }
    # match a or b
    or () { l="$1"; { re "$1" "$2"; } || { shift 2; [ "$#" -gt 0 ] && or "$l" "${@}"; } || false; }
    # match a(ba)+
    n1 () { l="$1"; b="$2"; shift 2; ! or "$l" "$@" || { ! re "$l" "$b" || n1 "$l" "$b" "$@"; } }

    or "major" "$SD" "0" && re "" "\." && \
    or "minor" "$SD" "0" && re "" "\." && \
    or "patch" "$SD" "0" && \
    { ! re "" "-" || n1 "prerelease" "\." "$PW" "$SD" "0"; } && \
    { ! re "" "+" || n1 "buildmetadata" "\." "$MW"; } && \
    [ -z "$v" ]
}
