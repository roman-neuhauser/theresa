#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

cmd-impl user \
  at-home-in=PATHNAME assert-user-at-home-in \
  in-group=GROUP      assert-user-in-group \
  -- "$@"
