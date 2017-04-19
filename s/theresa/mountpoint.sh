#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2


zmodload -F zsh/stat b:zstat

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

declare -r t=mountpoint

declare -A st
zstat -oLH st $arg || fail -x $t $arg does not exist
itsa directory "${(@kv)st}" || fail --detect $arg "${(@kv)st}"
# a hole
fail -x directory $arg is not a $t

I=
N=
A=
while haveopt I N A \
  empty non-empty owned-by= in-group= mode= \
  -- "$@"
do
  case $N in
  owned-by)
    assert-owned-by $t $arg $A "${(@kv)st}"
  ;;
  in-group)
    assert-in-group $t $arg $A "${(@kv)st}"
  ;;
  mode)
    assert-mode $t $arg $A "${(@kv)st}"
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
