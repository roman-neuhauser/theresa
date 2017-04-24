::

  $ . $TESTDIR/setup

  $ export fake_zstat=1

  $ fake -x 1 getpwent -qu rofl


unknown option::

  $ mkzstat -oLH st . -- mode 040755

  $ theresa dir . --omg
  theresa-dir: ERROR: unknown option '--omg'
  [1]


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
  [1]

  $ mkzstat -oLH st snafu -- uid 0 gid 0 mode 040755 size 3

  $ theresa dir snafu --non-empty

  $ theresa dir snafu --empty
  FAIL: directory snafu is not empty
  [1]

what about permissions? ::

  $ echo 69 | fake -vo getpwent -qu lmao
  $ echo lmao | fake -vo getpwent -qn 69

  $ echo 42 | fake -vo getgrent -qg omgwtf
  $ echo omgwtf | fake -vo getgrent -qn 42

  $ mkzstat -oLH st snafu \
  > -- uid 69 gid 42 mode 040710 size 3

  $ theresa dir snafu --owned-by rofl
  FAIL: directory snafu is owned by lmao, not rofl
  [1]

  $ theresa dir snafu --owned-by lmao

  $ fake -x 1 getgrent -qg noway

  $ theresa dir snafu --in-group noway
  FAIL: directory snafu is in group omgwtf, not noway
  [1]

  $ theresa dir snafu --in-group omgwtf

  $ theresa dir snafu --mode 0755
  FAIL: directory snafu has mode 0710, not 0755
  [1]

  $ theresa dir snafu --mode 0710
