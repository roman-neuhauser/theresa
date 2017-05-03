setup::

  $ . $TESTDIR/setup


unknown option::

  $ theresa netif --omg
  theresa-netif: ERROR: unknown option '--omg'
  [1]

help::

  $ theresa netif -h
  theresa: usage: theresa netif -h|--help
  theresa: usage: theresa netif NAME [PREDICATE...]
  
  Options:
  
    -h        Display this message.
  
  Predicates:
  
    --down
    --up

  $ theresa netif --help
  HELP
