::

  $ . $TESTDIR/setup

  $ export fake_zstat=1

  $ echo 200 | fake -o getpwent -Nqu somebody
  $ echo 100 | fake -o getpwent -Nqu nobody
  $ echo nobody | fake -o getpwent -INqn 100

  $ fake -x 1 getgrent -Nqg everybody
  $ echo 111 | fake -o getgrent -Nqg empty
  $ echo empty | fake -o getgrent -INqn 111


does it exist at all? ::

  $ theresa symlink snafu
  FAIL: symlink snafu does not exist
  [1]

  $ mkzstat -oLH st snafu -- mode 040755

  $ theresa symlink snafu
  FAIL: snafu is a directory
  [1]

  $ mkzstat -oLH st snafu -- mode 0120755 uid 100 gid 111

  $ theresa symlink snafu


what does it point at? ::

  $ mkzstat -oLH st rofl -- mode 0120755 link lmao

  $ theresa symlink rofl --to fubar
  FAIL: symlink rofl points to lmao
  [1]

  $ theresa symlink rofl --to lmao


what about permissions? ::

  $ theresa symlink snafu --owned-by somebody
  FAIL: symlink snafu is owned by nobody, not somebody
  [1]

  $ theresa symlink snafu --owned-by nobody

  $ theresa symlink snafu --in-group everybody
  FAIL: symlink snafu is in group empty, not everybody
  [1]

  $ theresa symlink snafu --in-group empty
