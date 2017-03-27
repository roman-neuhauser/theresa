#!/bin/sh

. haveopt.sh

while haveopt I N A h help -- "$@"; do
  :
done; shift $I

cmd="${1?}"; shift

case "$cmd" in
blockdev)   theresa-"$cmd" "$@" ;;
chardev)    theresa-"$cmd" "$@" ;;
dir)        theresa-"$cmd" "$@" ;;
file)       theresa-"$cmd" "$@" ;;
group)      theresa-"$cmd" "$@" ;;
mountpoint) theresa-"$cmd" "$@" ;;
netif)      theresa-"$cmd" "$@" ;;
pipe)       theresa-"$cmd" "$@" ;;
socket)     theresa-"$cmd" "$@" ;;
symlink)    theresa-"$cmd" "$@" ;;
user)       theresa-"$cmd" "$@" ;;
*)          printf >&2 -- "OMG OMG OMG\n"; exit 100; ;;
esac

