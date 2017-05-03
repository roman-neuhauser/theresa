#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

function assert-dir-empty # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -A st; zstat -oLH st $arg
  :; (( st[size] < 3 )) \
  || fail $t $arg is not empty
} # }}}

function assert-dir-non-empty # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -A st; zstat -oLH st $arg
  :; (( st[size] > 2 )) \
  || fail $t $arg is empty
} # }}}

cmd-impl directory \
  --meta=PATHNAME \
  empty           assert-dir-empty \
  non-empty       assert-dir-non-empty \
  in-group=GROUP  assert-path-in-group \
  mode=PERMS      assert-path-mode \
  owned-by=USER   assert-path-owned-by \
  -- "$@"
