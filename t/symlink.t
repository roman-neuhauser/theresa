::

  $ . $TESTDIR/setup


does it exist at all? ::

  $ theresa symlink snafu
  FAIL: symlink snafu does not exist
  [1]

  $ mkdir snafu

  $ theresa symlink snafu
  FAIL: snafu is a directory
  [1]

  $ rmdir snafu
  $ ln -s . snafu

  $ theresa symlink snafu


what does it point at? ::

  $ ln -s lmao rofl

  $ theresa symlink rofl --to fubar
  FAIL: symlink rofl points to lmao

  $ theresa symlink rofl --to lmao


what about permissions? ::

  $ chown -R $(id -nu):$(id -ng) snafu
  $ chmod 0710 snafu

  $ theresa symlink snafu --owned-by not-$(id -nu)
  FAIL: symlink snafu is owned by * (glob)

  $ theresa symlink snafu --owned-by $(id -nu)

  $ theresa symlink snafu --in-group not-$(id -ng)
  FAIL: symlink snafu is in group * (glob)

  $ theresa symlink snafu --in-group $(id -ng)
