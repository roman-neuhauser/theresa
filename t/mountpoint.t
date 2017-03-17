::

  $ . $TESTDIR/setup


does it exist at all? ::

  $ theresa mountpoint snafu
  FAIL: mountpoint snafu does not exist

  $ mkdir snafu

  $ theresa mountpoint snafu
  FAIL: directory snafu is not a mountpoint

  $ rmdir snafu
  $ touch snafu

  $ theresa mountpoint snafu
  FAIL: mountpoint snafu is a plain file
