#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

handle-predicates group $arg \
  not-password-protected \
    assert-group-not-password-protected \
  password-protected \
    assert-group-password-protected \
  with-member= \
    assert-group-with-member \
  -- "$@"
