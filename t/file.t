::

  $ . $TESTDIR/setup

  $ export fake_zstat=1

  $ fake -x 1 getpwent -qu whoever

  $ echo thatguy | fake -o getpwent -qn 234
  $ echo 234 | fake -o getpwent -qu thatguy

  $ fake -x 1 getgrent -qg people

  $ echo 345 | fake -o getgrent -qg thoseguys
  $ echo thoseguys | fake -o getgrent -qn 345


does it exist at all? ::

  $ theresa file snafu
  FAIL: file snafu does not exist
  [1]

  $ mkzstat -oLH st snafu \
  > -- mode 040755

  $ theresa file snafu
  FAIL: snafu is a directory
  [1]

  $ mkzstat -oLH st snafu \
  > -- mode 0100755

  $ theresa file snafu

is it empty? ::

  $ theresa file snafu --empty

  $ theresa file snafu --non-empty
  FAIL: file snafu is empty
  [1]

  $ mkzstat -oLH st snafu \
  > -- mode 0100755 size 1

  $ theresa file snafu --non-empty

  $ theresa file snafu --empty
  FAIL: file snafu is not empty
  [1]

what about permissions? ::

  $ mkzstat -oLH st snafu \
  > -- mode 0100710 uid 234 gid 345 size 2864

  $ theresa file snafu --owned-by whoever
  FAIL: file snafu is owned by thatguy, not whoever
  [1]

  $ theresa file snafu --owned-by thatguy

  $ theresa file snafu --in-group people
  FAIL: file snafu is in group thoseguys, not people
  [1]

  $ theresa file snafu --in-group thoseguys

  $ theresa file snafu --mode 0755
  FAIL: file snafu has mode 0710, not 0755
  [1]

  $ theresa file snafu --mode 0710
