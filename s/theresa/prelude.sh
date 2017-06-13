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

function fail # {{{
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
    printf -->&2 "ERROR: $0: unknown object type %s\n" "${(qq)st[mode]}"
  ;;
  -x)
    ex=1
    shift
  ;;
  esac
  printf -->&2 "FAIL: %s\n" "$*"
  FAILURES=$(( FAILURES + 1 ))
  (( ex == 0 )) || exit 1
} # }}}

function itsa # {{{
{
  local t=$1; shift
  local -A st; st=("$@")
  case $t in
  blockdev)   (( (st[mode] & 8#170000) == 8#060000 )) ;;
  chardev)    (( (st[mode] & 8#170000) == 8#020000 )) ;;
  mountpoint) ;&
  directory)  (( (st[mode] & 8#170000) == 8#040000 )) ;;
  file)       (( (st[mode] & 8#170000) == 8#100000 )) ;;
  pipe)       (( (st[mode] & 8#170000) == 8#010000 )) ;;
  symlink)    (( (st[mode] & 8#170000) == 8#120000 )) ;;
  socket)     (( (st[mode] & 8#170000) == 8#140000 )) ;;
  whiteout)   (( (st[mode] & 8#170000) == 8#160000 )) ;;
  *)
    printf -->&2 "ERROR: $0: unknown object type %s\n" "${(qq)t}"
  ;;
  esac
} # }}}

function cmd-impl # {{{
{
  declare -r t=$1; shift
  declare meta=

  declare I=0 N= A=
  while haveopt I N A meta= -- "$@"; do
    case $N in
    meta) meta=$A ;;
    *) unknown-option $t '' $I $N $A ;;
    esac
  done; shift $I

  declare -i seppos="$@[(i)--]"
  declare k v
  declare -A handlers
  declare -a specs
  for k v in "$@[1,seppos-1]"; do
    specs+=($k)
    handlers+=(${k/=*/=} $v)
  done
  shift $seppos

  declare I=0 N= A=
  while haveopt I N A h help -- "$@"; do
    case $N in
    help) echo HELP; exit ;;
    h) cmd-usage "$meta" $specs; exit ;;
    *) unknown-option $t '' $I $N $A ;;
    esac
  done; shift $I

  handle-predicates $t $1 ${(kv)handlers} -- "$@[2,-1]"
} # }}}

function cmd-usage # {{{
{
  declare -r self=${SELF/-/ } sym=${1:-NAME}; shift
  cat <<EOF
${self/ */}: usage: $self -h|--help
${self/ */}: usage: $self $sym [PREDICATE...]

Options:

  -h        Display this message.

Predicates:

EOF
  declare on oa
  for on in "${(@o)@}"; do
    case $on in
    *=?*) printf -- "  --%-8s %s\n" ${(s:=:)on} ;;
    *)    printf -- "  --%s\n" ${on/%=} ;;
    esac
  done
} # }}}

function handle-predicates # {{{
{
  declare t=$1 arg=$2
  shift 2
  declare -i seppos="$@[(i)--]"
  declare -A handlers
  handlers=("$@[1,seppos-1]")
  shift $seppos
  declare k v
  declare I=
  declare N=
  declare A=

  I=0 N= A=
  while haveopt I N A "${(@k)handlers}" -- "$@"; do
    case $N in
    ${(~kj:|:)handlers/%=/}) : ;;
    *) unknown-option $t $arg "$I" "$N" "$A" ;;
    esac
  done

  declare -A st
  assert-presence $t $arg st

  I=0 N= A=
  while haveopt I N A "${(@k)handlers}" -- "$@"; do
    case $N in
    ${(~kj:|:)handlers/%=/})
      ${handlers[$N=]-$handlers[$N]} $t $arg "${A-}" ${st+"${(@kv)st}"}
    ;;
    esac
  done

  return $(( FAILURES != 0 ))
} # }}}

function unknown-option # {{{
{
  declare -r t=$1 arg=$2 A=$5
  declare a=
  case $A in
  ?) a=-$A ;;
  *) a=--$A ;;
  esac
  printf -->&2 "%s: ERROR: unknown option %s\n" "$SELF" "${(qq)a-}"
  exit 1
} # }}}

function assert-presence # {{{
{
  ${$(whence assert-$1-presence):-assert-path-presence} "$@"
} # }}}

function assert-path-presence # {{{
{
  zmodload -F zsh/stat b:zstat

  declare -r t=$1 arg=$2
  declare -A st
  zstat -oLH st $arg 2>/dev/null || fail -x $t $arg does not exist
  :; itsa $t "${(@kv)st}" \
  || fail --detect $arg "${(@kv)st}"
} # }}}

function assert-path-owned-by # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -A st; zstat -oLH st $arg
  declare uid=$(getpwent -Nqu $A || :)
  :; [[ $st[uid] == $uid ]] \
  || fail $t $arg is owned by $(getpwent -INqn $st[uid]), not $A
} # }}}

function assert-path-in-group # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -A st; zstat -oLH st $arg
  declare gid=$(getgrent -Nqg $A || :)
  :; [[ $st[gid] == $gid ]] \
  || fail $t $arg is in group $(getgrent -INqn $st[gid]), not $A
} # }}}

function assert-path-mode # {{{
{
  declare -r t=$1 arg=$2 A=$3
  declare -A st; zstat -oLH st $arg
  declare -i 8 mode=$((st[mode] & ~8#170000))
  :; (( mode == A )) \
  || fail $t $arg has mode $mode, not $A
} # }}}
