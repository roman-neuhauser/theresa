#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

declare -r t=user

getpwent -q $arg || fail $t $arg does not exist

I=
N=
A=
while haveopt I N A \
  at-home-in= in-group= \
  -- "$@"
do
  case $N in
  ( at-home-in \
  | in-group )
    assert-user-$N $t $arg "${A-}"
  ;;
  *)
    unknown-option $t $arg "$I" "$N" "$A"
  ;;
  esac
done

exit $(( FAILURES != 0 ))
