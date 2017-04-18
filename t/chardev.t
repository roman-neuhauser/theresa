::

  $ . $TESTDIR/setup


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
