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

function fail
{
  printf >&2 -- "FAIL: %s\n" "$*"
}
