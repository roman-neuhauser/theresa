#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

zmodload -F zsh/stat b:zstat

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

declare -r t=chardev

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
  owned-by)
    [[ $st[uid] == $(id -u $A 2>/dev/null || :) ]] \
    || fail $t $arg is owned by $(id -nu $st[uid])
  ;;
  in-group)
    declare gid=$(getgrent -g $A || :)
    [[ $st[gid] == $gid ]] \
    || fail $t $arg is in group $(getgrent -n $st[gid]), not $A
  ;;
  mode)
    declare -A st
    zstat -L -H st $arg
    declare -i 8 mode=$((st[mode] & ~8#170000))
    (( $mode == $A )) \
    || fail $t $arg has mode $mode
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
