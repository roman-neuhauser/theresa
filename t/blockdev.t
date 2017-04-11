::

  $ . $TESTDIR/setup

  $ export fake_zstat=1

  $ mkzstat -oLH st fubar -- mode 060640
  $ mkzstat -oLH st snafu -- -x 1
  $ mkzstat -oLH st lol -- mode 020644
  $ mkzstat -oLH st . -- mode 040755

::

  $ theresa blockdev fubar
  $ theresa blockdev snafu
  FAIL: blockdev snafu does not exist
  [1]

  $ theresa blockdev .
  FAIL: . is a directory
  [1]
