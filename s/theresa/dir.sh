#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

cmd-impl directory \
  --meta=PATHNAME \
  empty           assert-dir-empty \
  non-empty       assert-dir-non-empty \
  in-group=GROUP  assert-path-in-group \
  mode=PERMS      assert-path-mode \
  owned-by=USER   assert-path-owned-by \
  -- "$@"
