#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

function assert-netif-presence # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -a ifaces; ifaces=($(ifconfig -l))
  :; [[ -n ${(M)ifaces:#$arg} ]] \
  || fail $t $arg does not exist
} # }}}

function assert-netif-down # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -a ifaces; ifaces=($(ifconfig -ld || :))
  :; [[ -n ${(M)ifaces:#$arg} ]] \
  || fail $t $arg is not down
} # }}}

function assert-netif-up # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -a ifaces; ifaces=($(ifconfig -lu || :))
  :; [[ -n ${(M)ifaces:#$arg} ]] \
  || fail $t $arg is not up
} # }}}

cmd-impl netif \
  down assert-netif-down \
  up   assert-netif-up \
  -- "$@"
