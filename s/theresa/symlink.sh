#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

cmd-impl symlink \
  owned-by= assert-path-owned-by \
  in-group= assert-path-in-group \
  mode=     assert-path-mode \
  to=       assert-symlink-to \
  -- "$@"
