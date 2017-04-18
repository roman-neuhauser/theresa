::

  $ . $TESTDIR/setup

  $ export FAKE_BINDIR="$PWD"
  $ export PATH="$FAKE_BINDIR:$PATH"

  $ echo 0 | fake -o getgrent -g wheel
  $ echo wheel | fake -o getgrent -n 0


::

  $ theresa chardev /dev/null

  $ theresa chardev /dev/null \
  > --mode 0666

  $ theresa chardev /dev/null \
  > --in-group wheel

  $ theresa chardev /dev/null \
  > --owned-by root

  $ theresa chardev /dev/null \
  > --mode 0111 \
  > --in-group wheel \
  > --owned-by root
  FAIL: chardev /dev/null has mode 0666
