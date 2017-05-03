#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

declare -gr SYNOPSIS_SYMBOL=PATHNAME

cmd-impl pipe \
  owned-by=USER  assert-path-owned-by \
  in-group=GROUP assert-path-in-group \
  mode=PERMS     assert-path-mode \
  -- "$@"
