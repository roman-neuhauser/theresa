# vim: sw=2 sts=2 et fdm=marker cms=\ #\ %s

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

. haveopt.sh

declare -gi FAILURES

function fail
{
  local ex=0
  case $1 in
  --detect)
    local arg=$2
    shift 2
    local -A st; st=("$@")
    ! itsa directory "${(@kv)st}" || fail -x $arg is a directory
    ! itsa chardev   "${(@kv)st}" || fail -x $arg is a chardev
    ! itsa blockdev  "${(@kv)st}" || fail -x $arg is a blockdev
    ! itsa file      "${(@kv)st}" || fail -x $arg is a regular file
    ! itsa pipe      "${(@kv)st}" || fail -x $arg is a named pipe or socket
    ! itsa symlink   "${(@kv)st}" || fail -x $arg is a symbolic link
    ! itsa socket    "${(@kv)st}" || fail -x $arg is a socket
    ! itsa whiteout  "${(@kv)st}" || fail -x $arg is a whiteout
    printf -- >&2 "ERROR: $0: unknown object type %s\n" "${(qq)st[mode]}"
  ;;
  -x)
    ex=1
    shift
  ;;
  esac
  printf >&2 -- "FAIL: %s\n" "$*"
  FAILURES=$(( FAILURES + 1 ))
  (( ex == 0 )) || exit 1
}

function itsa
{
  local t=$1; shift
  local -A st; st=("$@")
  case $t in
  blockdev)   (( ($st[mode] & 8#170000) == 8#060000 )) ;;
  chardev)    (( ($st[mode] & 8#170000) == 8#020000 )) ;;
  directory)  (( ($st[mode] & 8#170000) == 8#040000 )) ;;
  file)       (( ($st[mode] & 8#170000) == 8#100000 )) ;;
  pipe)       (( ($st[mode] & 8#170000) == 8#010000 )) ;;
  symlink)    (( ($st[mode] & 8#170000) == 8#120000 )) ;;
  socket)     (( ($st[mode] & 8#170000) == 8#140000 )) ;;
  whiteout)   (( ($st[mode] & 8#170000) == 8#160000 )) ;;
  *)
    printf -- >&2 "ERROR: $0: unknown object type %s\n" "${(qq)t}"
  ;;
  esac
}

function assert-owned-by # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -A st; st="${(@)@[4,$#]}"
  declare uid=$(getpwent -u $A 2>/dev/null || :)
  :; [[ $st[uid] == $uid ]] \
  || fail $t $arg is owned by $(getpwent -n $st[uid]), not $A
} # }}}

function assert-in-group # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -A st; st="${(@)@[4,$#]}"
  declare gid=$(getgrent -g $A 2>/dev/null || :)
  :; [[ $st[gid] == $gid ]] \
  || fail $t $arg is in group $(getgrent -n $st[gid]), not $A
} # }}}

function assert-mode # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -A st; st="${(@)@[4,$#]}"
  declare -i 8 mode=$((st[mode] & ~8#170000))
  :; (( $mode == $A )) \
  || fail $t $arg has mode $mode, not $A
} # }}}
