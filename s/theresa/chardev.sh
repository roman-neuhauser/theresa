#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

zmodload -F zsh/stat b:zstat

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

declare -A st
zstat -oLH st $arg || fail -x chardev $arg does not exist
itsa chardev "${(@kv)st}" || fail --detect $arg "${(@kv)st}"

I=
N=
A=
while haveopt I N A \
  empty non-empty owned-by= in-group= mode= \
  -- "$@"
do
  case $N in
  empty)
    [[ ! -s $arg ]] \
    || fail chardev $arg is not empty
  ;;
  non-empty)
    [[ -s $arg ]] \
    || fail chardev $arg is empty
  ;;
  owned-by)
    declare -A st
    zstat -L -H st $arg
    [[ $st[uid] == $(id -u $A 2>/dev/null || :) ]] \
    || fail chardev $arg is owned by $(id -nu $st[uid])
  ;;
  in-group)
    declare -A st
    zstat -L -H st $arg
    [[ $st[gid] == $(id -g $A 2>/dev/null || :) ]] \
    || fail chardev $arg is in group $(id -ng $st[gid]), not $A
  ;;
  mode)
    declare -A st
    zstat -L -H st $arg
    declare -i 8 mode=$((st[mode] & ~8#170000))
    (( $mode == $A )) \
    || fail chardev $arg has mode $mode
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
