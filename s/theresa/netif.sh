#!@ZSH@ -f

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

function fail
{
  printf >&2 -- "FAIL: %s\n" "$*"
}

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

arg="${1?}"; shift

ifaces=($(ifconfig -l))
[[ -n ${(M)ifaces:#$arg} ]] \
|| fail netif $arg does not exist

I=
N=
A=
while haveopt I N A \
  down up \
  -- "$@"
do
  case $N in
  down)
    ifaces=($(ifconfig -ld || :))
    [[ -n ${(M)ifaces:#$arg} ]] \
    || fail netif $arg is not down
  ;;
  up)
    ifaces=($(ifconfig -lu || :))
    [[ -n ${(M)ifaces:#$arg} ]] \
    || fail netif $arg is not up
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
