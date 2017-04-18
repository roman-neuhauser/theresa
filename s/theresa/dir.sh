#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

zmodload -F zsh/stat b:zstat

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

declare -r t=directory

declare -A st
zstat -oLH st $arg 2>/dev/null || fail -x $t $arg does not exist
itsa $t "${(@kv)st}" || fail --detect $arg "${(@kv)st}"

I=
N=
A=
while haveopt I N A \
  empty non-empty owned-by= in-group= mode= \
  -- "$@"
do
  case $N in
  empty)
    (( $st[size] < 3 )) \
    || fail $t $arg is not empty
  ;;
  non-empty)
    (( $st[size] > 2 )) \
    || fail $t $arg is empty
  ;;
  owned-by)
    [[ $st[uid] == $(getpwent -u $A 2>/dev/null || :) ]] \
    || fail $t $arg is owned by $(getpwent -n $st[uid])
  ;;
  in-group)
    [[ $st[gid] == $(getgrent -g $A 2>/dev/null || :) ]] \
    || fail $t $arg is in group $(getgrent -n $st[gid])
  ;;
  mode)
    declare -i 8 mode=$((st[mode] & ~8#170000))
    (( $mode == $A )) \
    || fail $t $arg has mode $mode
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
