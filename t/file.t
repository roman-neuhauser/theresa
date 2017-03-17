::

  $ . $TESTDIR/setup

does it exist at all? ::

  $ theresa file snafu
  FAIL: file snafu does not exist

  $ mkdir snafu

  $ theresa file snafu
  FAIL: file snafu is a directory

  $ rmdir snafu
  $ touch snafu

  $ theresa file snafu

is it empty? ::

  $ theresa file snafu --empty

  $ theresa file snafu --non-empty
  FAIL: file snafu is empty

  $ printf : > snafu

  $ theresa file snafu --non-empty

  $ theresa file snafu --empty
  FAIL: file snafu is not empty

what about permissions? ::

  $ chown -R $(id -nu):$(id -ng) snafu
  $ chmod 0710 snafu

  $ theresa file snafu --owned-by not-$(id -nu)
  FAIL: file snafu is owned by * (glob)

  $ theresa file snafu --owned-by $(id -nu)

  $ theresa file snafu --in-group not-$(id -ng)
  FAIL: file snafu is in group * (glob)

  $ theresa file snafu --in-group $(id -ng)

  $ theresa file snafu --mode 0755
  FAIL: file snafu has mode 0710

  $ theresa file snafu --mode 0710
