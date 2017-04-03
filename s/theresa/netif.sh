#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

ifaces=($(ifconfig -l))
[[ -n ${(M)ifaces:#$arg} ]] \
|| fail netif $arg does not exist

I=
N=
A=
while haveopt I N A \
  down up \
  -- "$@"
do
  case $N in
  down)
    ifaces=($(ifconfig -ld || :))
    [[ -n ${(M)ifaces:#$arg} ]] \
    || fail netif $arg is not down
  ;;
  up)
    ifaces=($(ifconfig -lu || :))
    [[ -n ${(M)ifaces:#$arg} ]] \
    || fail netif $arg is not up
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
