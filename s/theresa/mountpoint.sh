#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

function assert-mountpoint-presence # {{{
{
  declare -r t=$1 arg=$2
  assert-path-presence "$@"
  # a hole
  fail -x directory $arg is not a $t
} # }}}

cmd-impl mountpoint \
  --meta=PATHNAME \
  owned-by=USER  assert-path-owned-by \
  in-group=GROUP assert-path-iin-group \
  mode=PERMS     assert-path-mode \
  -- "$@"
