::

  $ . $TESTDIR/setup
  $ export FAKE_BINDIR=$(mktemp -d)
  $ export PATH="$FAKE_BINDIR:$PATH"


does it exist at all? ::

  $ theresa netif fubar
  FAIL: netif fubar does not exist


it is neither up nor down ::

  $ fake -cx 1 ifconfig
  $ echo fubar | fake -o ifconfig -l

  $ theresa netif fubar --up
  FAIL: netif fubar is not up

  $ theresa netif fubar --down
  FAIL: netif fubar is not down


it is up ::

  $ rm -rf $FAKE_BINDIR/.ifconfig

  $ fake -cx 1 ifconfig
  $ echo fubar | fake -o ifconfig -l
  $ echo fubar | fake -o ifconfig -lu

  $ theresa netif fubar --up

  $ theresa netif fubar --down
  FAIL: netif fubar is not down


it is down ::

  $ rm -rf $FAKE_BINDIR/.ifconfig

  $ fake -cx 1 ifconfig
  $ echo fubar | fake -o ifconfig -l
  $ echo fubar | fake -o ifconfig -ld

  $ theresa netif fubar --down

  $ theresa netif fubar --up
  FAIL: netif fubar is not up
