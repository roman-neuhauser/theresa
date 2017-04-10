#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2


zmodload -F zsh/stat b:zstat

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

declare -A st
zstat -oLH st $arg || fail blockdev $arg does not exist
(( st[mode] & 8#60000 )) || {
  (( 0 == (st[mode] & 8#40000) )) || fail blockdev $arg is a directory
}

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
    || fail blockdev $arg is not empty
  ;;
  non-empty)
    [[ -s $arg ]] \
    || fail blockdev $arg is empty
  ;;
  owned-by)
    declare uid=$(getpwent -u $A 2>/dev/null || :)
    [[ $st[uid] == $uid ]] \
    || fail blockdev $arg is owned by $(getpwent -n $st[uid]), not $A
  ;;
  in-group)
    declare gid=$(getgrent -g $A 2>/dev/null || :)
    [[ $st[gid] == $gid ]] \
    || fail blockdev $arg is in group $(getgrent -n $st[gid]), not $A
  ;;
  mode)
    declare -i 8 mode=$((st[mode] & ~8#170000))
    (( $mode == $A )) \
    || fail blockdev $arg has mode $mode, not $A
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
