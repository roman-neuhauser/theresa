::

  $ . $TESTDIR/setup

  $ export fake_zstat=1

  $ mkzstat -oLH st fubar -- uid 0 gid 0 mode 060640
  $ mkzstat -oLH st snafu -- -x 1
  $ mkzstat -oLH st lol -- mode 020644
  $ mkzstat -oLH st . -- mode 040755

  $ fake -x 1 getpwent -qu nobody


::

  $ theresa blockdev fubar
  $ theresa blockdev snafu
  FAIL: blockdev snafu does not exist
  [1]

  $ theresa blockdev .
  FAIL: . is a directory
  [1]

  $ theresa blockdev lol --owned-by whoever
  FAIL: lol is a chardev
  [1]

  $ theresa blockdev fubar --owned-by nobody
  FAIL: blockdev fubar is owned by root, not nobody
  [1]

  $ theresa blockdev fubar --owned-by root --in-group wheel --mode 666
  FAIL: blockdev fubar has mode 0640, not 666
  [1]
