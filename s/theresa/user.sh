#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

declare -r t=user

getpwent $arg 2>/dev/null || fail $t $arg does not exist

I=
N=
A=
while haveopt I N A \
  at-home-in= in-group= \
  -- "$@"
do
  case $N in
  at-home-in)
    declare h=${$(getpwent -qd $arg)#dir=}
    :; [[ $h == $A ]] \
    || fail $t $arg is at home in $h
  ;;
  in-group)
    :; getgrent -qt $arg "$A" \
    || fail $t $arg is not in group $A
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done

exit $(( FAILURES != 0 ))
