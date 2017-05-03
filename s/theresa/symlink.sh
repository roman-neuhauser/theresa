#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

function assert-symlink-to # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -A st; zstat -oLH st $arg
  :; [[ $st[link] == $A ]] \
  || fail $t $arg points to $st[link]
} # }}}

cmd-impl symlink \
  --meta=PATHNAME \
  owned-by=USER  assert-path-owned-by \
  in-group=GROUP assert-path-in-group \
  mode=PERMS     assert-path-mode \
  to=PATHNAME    assert-symlink-to \
  -- "$@"
