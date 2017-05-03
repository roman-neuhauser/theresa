#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

cmd-impl group \
  not-password-protected \
    assert-group-not-password-protected \
  password-protected \
    assert-group-password-protected \
  with-member=USER \
    assert-group-with-member \
  -- "$@"
