#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

function assert-group-presence # {{{
{
  declare -r t=$1 arg=$2
  :; getgrent -q $arg \
  || fail $t $arg does not exist
} # }}}

function assert-group-not-password-protected # {{{
{
  declare -r t=$1 arg=$2
  : \
  || fail $t $arg has a password
} # }}}

function assert-group-password-protected # {{{
{
  declare -r t=$1 arg=$2
  : \
  || fail $t $arg has no password
} # }}}

function assert-group-with-member # {{{
{
  declare -r t=$1 arg=$2 A=$3
  : \
  || fail user $arg is not in $t "$A"
} # }}}

cmd-impl group \
  not-password-protected \
    assert-group-not-password-protected \
  password-protected \
    assert-group-password-protected \
  with-member=USER \
    assert-group-with-member \
  -- "$@"
