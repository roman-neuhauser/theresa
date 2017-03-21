::

  $ . $TESTDIR/setup

  $ export FAKE_BINDIR=$(mktemp -d)
  $ export PATH="$FAKE_BINDIR:$PATH"

does it exist at all? ::

  $ fake -x 1 getpwent fubar

  $ theresa user fubar
  FAIL: user fubar does not exist


where is its home at? ::

  $ fake -x 0 getpwent fubar
  $ echo /some/where | fake -o getpwent -qd fubar

  $ theresa user fubar --at-home-in /some/where


is it in a certain group? ::

  $ fake -x 0 getgrent -qt fubar snafu

  $ theresa user fubar --in-group snafu
