::

  $ . $TESTDIR/setup

  $ export fake_zstat=1

does it exist at all? ::

  $ mkzstat -oLH st snafu -- -x 1

  $ theresa mountpoint snafu
  FAIL: mountpoint snafu does not exist
  [1]

  $ mkzstat -oLH st snafu -- mode 0040755

  $ theresa mountpoint snafu
  FAIL: directory snafu is not a mountpoint
  [1]

  $ mkzstat -oLH st snafu -- mode 0100744

  $ theresa mountpoint snafu
  FAIL: snafu is a regular file
  [1]
