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

getgrent $arg 2>/dev/null || fail group $arg does not exist

I=
N=
A=
while haveopt I N A \
  {,not-}password-protected with-member= \
  -- "$@"
do
  case $N in
  not-password-protected)
    : \
    || fail group $arg has a password
  ;;
  password-protected)
    : \
    || fail group $arg has no password
  ;;
  with-member)
    : \
    || fail user $arg is not in group "$A"
  ;;
  *) echo "I=$I N=$N A=${A-}" ;;
  esac
done
