::

  $ . $TESTDIR/setup

  $ fake -x 1 getgrent -q fubar

does it exist at all? ::

  $ theresa group fubar
  FAIL: group fubar does not exist
  [1]
