::

  $ . $TESTDIR/setup
  $ export FAKE_BINDIR=$(mktemp -d)
  $ export PATH="$FAKE_BINDIR:$PATH"
  $ export FAKE_TEST=y

  $ fake -bc test <<\EOF
  > #!/bin/sh
  > builtin test "$@"
  > EOF

  $ fake -x 0 test -e fubar
  $ fake -x 0 test -b fubar
  $ fake -x 1 test -b snafu

::

  $ theresa blockdev fubar
  $ theresa blockdev snafu
  FAIL: blockdev snafu does not exist
