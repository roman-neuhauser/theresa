::

  $ . $TESTDIR/setup


does it exist at all? ::

  $ theresa user fubar
  FAIL: user fubar does not exist


where is its home at? ::

  $ theresa user fubar --at-home-in /some/where


is it in a certain group? ::

  $ theresa user fubar --in-group snafu
