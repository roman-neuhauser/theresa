::

  $ . $TESTDIR/setup


does it exist at all? ::

  $ theresa pipe snafu
  FAIL: pipe snafu does not exist

  $ mkdir snafu

  $ theresa pipe snafu
  FAIL: pipe snafu is a directory

  $ rmdir snafu
  $ mkfifo snafu

  $ theresa pipe snafu


what about permissions? ::

  $ chown -R $(id -nu):$(id -ng) snafu
  $ chmod 0710 snafu

  $ theresa pipe snafu --owned-by not-$(id -nu)
  FAIL: pipe snafu is owned by * (glob)

  $ theresa pipe snafu --owned-by $(id -nu)

  $ theresa pipe snafu --in-group not-$(id -ng)
  FAIL: pipe snafu is in group * (glob)

  $ theresa pipe snafu --in-group $(id -ng)

  $ theresa pipe snafu --mode 0755
  FAIL: pipe snafu has mode 0710

  $ theresa pipe snafu --mode 0710
