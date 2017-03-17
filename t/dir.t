::

  $ . $TESTDIR/setup

does it exist at all? ::

  $ theresa dir snafu
  FAIL: dir snafu does not exist

  $ touch snafu

  $ theresa dir snafu
  FAIL: dir snafu is a plain file

  $ rm snafu
  $ mkdir snafu

  $ theresa dir snafu

is it empty? ::

  $ theresa dir snafu --empty

  $ theresa dir snafu --non-empty
  FAIL: dir snafu is empty

  $ touch snafu/fubar

  $ theresa dir snafu --non-empty

  $ theresa dir snafu --empty
  FAIL: dir snafu is not empty

what about permissions? ::

  $ chown -R $(id -nu):$(id -ng) snafu
  $ chmod 0710 snafu

  $ theresa dir snafu --owned-by not-$(id -nu)
  FAIL: dir snafu is owned by * (glob)

  $ theresa dir snafu --owned-by $(id -nu)

  $ theresa dir snafu --in-group not-$(id -ng)
  FAIL: dir snafu is in group * (glob)

  $ theresa dir snafu --in-group $(id -ng)

  $ theresa dir snafu --mode 0755
  FAIL: dir snafu has mode 0710

  $ theresa dir snafu --mode 0710
