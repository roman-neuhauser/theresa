#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

function assert-user-presence # {{{
{
  declare -r t=$1 arg=$2
  :; getpwent -q $arg \
  || fail $t $arg does not exist
} # }}}

function assert-user-at-home-in # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare h=$(getpwent -qd $arg)
  :; [[ $h == $A ]] \
  || fail $t $arg is at home in $h
} # }}}

function assert-user-in-group # {{{
{
  declare -r t=$1 arg=$2 A=$3
  :; getgrent -qt $arg "$A" \
  || fail $t $arg is not in group $A
} # }}}

cmd-impl user \
  at-home-in=PATHNAME assert-user-at-home-in \
  in-group=GROUP      assert-user-in-group \
  -- "$@"
