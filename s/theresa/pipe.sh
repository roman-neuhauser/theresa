#!@ZSH@ -f

declare -gr preludedir="${THERESA_PRELUDEDIR:-@preludedir@}"

. $preludedir/prelude || exit 2

zmodload -F zsh/stat b:zstat

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

[[ -p $arg ]] || {
  ; [[ -e $arg ]] || fail pipe $arg does not exist
  ! [[ -d $arg ]] || fail pipe $arg is a directory
  ! [[ -f $arg ]] || fail pipe $arg is a file
}

I=
N=
A=
while haveopt I N A \
  owned-by= in-group= mode= \
  -- "$@"
do
  case $N in
  owned-by)
    declare -A st
    zstat -L -H st $arg
    [[ $st[uid] == $(id -u $A 2>/dev/null || :) ]] \
    || fail pipe $arg is owned by $(id -nu $st[uid])
  ;;
  in-group)
    declare -A st
    zstat -L -H st $arg
    [[ $st[gid] == $(id -g $A 2>/dev/null || :) ]] \
    || fail pipe $arg is in group $(id -ng $st[gid])
  ;;
  mode)
    declare -A st
    zstat -L -H st $arg
    declare -i 8 mode=$((st[mode] & ~8#170000))
    (( $mode == $A )) \
    || fail pipe $arg has mode $mode
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
