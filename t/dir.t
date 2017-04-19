::

  $ . $TESTDIR/setup

  $ export fake_zstat=1


does it exist at all? ::

  $ mkzstat -oLH st snafu -- -x 1

  $ theresa dir snafu
  FAIL: directory snafu does not exist
  [1]

  $ mkzstat -oLH st snafu -- uid 0 gid 0 mode 100755

  $ theresa dir snafu
  FAIL: snafu is a regular file
  [1]

  $ mkzstat -oLH st snafu -- uid 0 gid 0 mode 040755 size 2

  $ theresa dir snafu

is it empty? ::

  $ theresa dir snafu --empty

  $ theresa dir snafu --non-empty
  FAIL: directory snafu is empty

  $ mkzstat -oLH st snafu -- uid 0 gid 0 mode 040755 size 3

  $ theresa dir snafu --non-empty

  $ theresa dir snafu --empty
  FAIL: directory snafu is not empty

what about permissions? ::

  $ echo 69 | fake -vo getpwent -u lmao
  $ echo lmao | fake -vo getpwent -n 69

  $ echo 42 | fake -vo getgrent -g omgwtf
  $ echo omgwtf | fake -vo getgrent -n 42

  $ mkzstat -oLH st snafu \
  > -- uid 69 gid 42 mode 040710 size 3

  $ theresa dir snafu --owned-by rofl
  FAIL: directory snafu is owned by lmao, not rofl

  $ theresa dir snafu --owned-by lmao

  $ theresa dir snafu --in-group noway
  FAIL: directory snafu is in group omgwtf, not noway

  $ theresa dir snafu --in-group omgwtf

  $ theresa dir snafu --mode 0755
  FAIL: directory snafu has mode 0710, not 0755

  $ theresa dir snafu --mode 0710
