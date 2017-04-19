#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

zmodload -F zsh/stat b:zstat

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

declare -r t=pipe

declare -A st
zstat -oLH st $arg 2>/dev/null || fail -x $t $arg does not exist
itsa $t "${(@kv)st}" || fail --detect $arg "${(@kv)st}"

I=
N=
A=
while haveopt I N A \
  owned-by= in-group= mode= \
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
