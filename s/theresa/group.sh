#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

declare -r t=group

getgrent $arg 2>/dev/null || fail $t $arg does not exist

I=
N=
A=
while haveopt I N A \
  {,not-}password-protected with-member= \
  -- "$@"
do
  case $N in
  not-password-protected)
    : \
    || fail $t $arg has a password
  ;;
  password-protected)
    : \
    || fail $t $arg has no password
  ;;
  with-member)
    : \
    || fail user $arg is not in $t "$A"
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done

exit $(( FAILURES != 0 ))
