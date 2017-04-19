::

  $ . $TESTDIR/setup

  $ export fake_zstat=1

  $ echo thatguy | fake -o getpwent -n 234
  $ echo 234 | fake -o getpwent -u thatguy

  $ echo 345 | fake -o getgrent -g thoseguys
  $ echo thoseguys | fake -o getgrent -n 345


does it exist at all? ::

  $ theresa pipe snafu
  FAIL: pipe snafu does not exist
  [1]

  $ mkzstat -oLH st snafu \
  > -- mode 040755

  $ theresa pipe snafu
  FAIL: snafu is a directory
  [1]

  $ mkzstat -oLH st snafu \
  > -- mode 010755

  $ theresa pipe snafu


what about permissions? ::

  $ mkzstat -oLH st snafu \
  > -- mode 010744 uid 234 gid 345

  $ theresa pipe snafu --owned-by pipeless
  FAIL: pipe snafu is owned by thatguy, not pipeless

  $ theresa pipe snafu --owned-by thatguy

  $ theresa pipe snafu --in-group pipeless
  FAIL: pipe snafu is in group thoseguys, not pipeless

  $ theresa pipe snafu --in-group thoseguys

  $ theresa pipe snafu --mode 0710
  FAIL: pipe snafu has mode 0744, not 0710

  $ theresa pipe snafu --mode 0744
