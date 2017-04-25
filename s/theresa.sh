#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

SELF="${0##*/}"

usage() # {{{
{
  local reason=$1 ex=0
  case $reason in
  operand)
    ex=100
    printf -->&2 'theresa: error: missing operand\n'
  ;;
  option)
    declare on="${2:?}"
    case $on in
    ?) on=-$on ;;
    *) on=--$on ;;
    esac
    ex=1
    printf -->&2 'theresa: error: unknown option %s\n' "$on"
  ;;
  esac
  printf -->&2 'theresa: usage: %s -h\n' "$SELF"
  printf -->&2 'theresa: usage: %s THING [PREDICATE...]\n' "$SELF"
  if [[ $reason != help ]]; then
    printf -->&2 'theresa: use `theresa -h` to display help\n'
  else
    cat >&2 <<-\EOF

	Options:

	  -h      Display this message.
EOF
  fi
  exit $ex
} # }}}


(( $# > 0 )) || usage 0

help_wanted=0

while haveopt I N A h help -- "$@"; do
case "$N" in
  h|help) help_wanted=$(expr $help_wanted + 1) ;;
  \?) usage option "$A" ;;
  *)
    printf -->&2 "theresa: BUG: unhandled option '%s'\n" "$N"
    exit 127
  ;;
esac
done; shift $I

(( ! help_wanted )) || usage help
(( $# > 0 )) || usage operand

cmd="theresa-${1?}"; shift

type "$cmd" >/dev/null 2>&1 || {
  printf -->&2 "theresa: error: cannot execute %s\n" "$cmd"
  exit 111
}

exec "$cmd" "$@"
