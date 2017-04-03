#!/usr/bin/env zsh

#. @PRELUDEDIR@/theresa.prelude

setopt no_rcs
setopt c_bases
setopt octal_zeroes
setopt extended_glob
setopt null_glob
setopt hist_subst_pattern
setopt pipe_fail
setopt err_return
setopt no_unset
setopt warn_create_global

zmodload -F zsh/stat b:zstat

. haveopt.sh

function fail
{
  printf >&2 -- "FAIL: %s\n" "$*"
}

[[ -z $FAKE_TEST ]] || disable test

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

test -e $arg || fail blockdev $arg does not exist
test -b $arg || {
  ! [[ -d $arg ]] || fail blockdev $arg is a directory
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
    declare -A st
    zstat -L -H st $arg
    [[ $st[uid] == $uid ]] \
    || fail blockdev $arg is owned by $(getpwent -n $st[uid]), not $A
  ;;
  in-group)
    declare gid=$(getgrent -g $A 2>/dev/null || :)
    declare -A st
    zstat -L -H st $arg
    [[ $st[gid] == $gid ]] \
    || fail blockdev $arg is in group $(getgrent -n $st[gid]), not $A
  ;;
  mode)
    declare -A st
    zstat -L -H st $arg
    declare -i 8 mode=$((st[mode] & ~8#170000))
    (( $mode == $A )) \
    || fail blockdev $arg has mode $mode, not $A
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
