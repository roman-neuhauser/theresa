#!/usr/bin/env zsh
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

SELF="${0##*/}"

. haveopt.sh

usage() # {{{
{
  local ex=${1-100}
  test $ex -ne 100 || printf -- >&2 'theresa: error: missing operand\n'
  test $ex -ne 1   || printf -- >&2 'theresa: error: unknown option %s\n' "${2:?}"
  printf >&2 'theresa: usage: %s -h|-hh\n' "$SELF"
  printf >&2 'theresa: usage: %s THING [PREDICATE...]\n' "$SELF"
  if test $ex -gt -2; then
    printf >&2 'theresa: use `theresa -hh` to display help\n'
  else
    cat >&2 <<-\EOF

	Options:

	  -h      Display short usage help.
	          Given twice, display full help.
EOF
  fi
  if test $ex -lt 0; then
    exit 0
  fi
  exit $ex
} # }}}


test $# -gt 0 || usage 0

usage=0

while haveopt I N A h help -- "$@"; do
case "$N" in
  h|help) usage=$(expr $usage + 1) ;;
  \?) usage 1 "-$A" ;;
  *)
    printf -- >&2 "theresa: BUG: unhandled option '%s'\n" "$N"
    exit 127
  ;;
esac
done; shift $I

test $usage -eq 0 || usage -$usage
test $# -gt 0 || usage 100

cmd="theresa-${1?}"; shift

type "$cmd" >/dev/null 2>&1 || {
  printf >&2 -- "theresa: error: cannot execute %s\n" "$cmd"
  exit 111
}

exec "$cmd" "$@"
