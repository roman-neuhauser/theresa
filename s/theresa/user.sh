#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

getpwent $arg 2>/dev/null || fail user $arg does not exist

I=
N=
A=
while haveopt I N A \
  at-home-in= in-group= \
  -- "$@"
do
  case $N in
  at-home-in)
    declare h="${$(getpwent -qd "$arg")#dir=}"
    :; [[ "$h" == "$A" ]] \
    || fail user $arg is at home in "$h"
  ;;
  in-group)
    :; getgrent -qt "$arg" "$A" \
    || fail user $arg is not in group "$A"
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
