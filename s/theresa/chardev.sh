#!@ZSH@ -f
# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

declare -gr SELF="${0##*/}"

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

zmodload -F zsh/stat b:zstat

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

declare -r t=chardev

declare -A st
assert-presence $t $arg st

I=
N=
A=
while haveopt I N A \
  empty non-empty owned-by= in-group= mode= \
  -- "$@"
do
  case $N in
  ( owned-by \
  | in-group \
  | mode )
    assert-path-$N $t $arg "${A-}" "${(@kv)st}"
  ;;
  *)
    unknown-option $t $arg "$I" "$N" "$A"
  ;;
  esac
done

exit $(( FAILURES != 0 ))
