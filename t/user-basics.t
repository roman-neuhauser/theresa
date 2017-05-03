setup::

  $ . $TESTDIR/setup


unknown option::

  $ theresa user --omg
  theresa-user: ERROR: unknown option '--omg'
  [1]


unknown predicate::

  $ theresa user fubar --omg
  theresa-user: ERROR: unknown option '--omg'
  [1]


help::

  $ theresa user -h
  theresa: usage: theresa user -h|--help
  theresa: usage: theresa user NAME [PREDICATE...]
  
  Options:
  
    -h        Display this message.
  
  Predicates:
  
    --at-home-in PATHNAME
    --in-group GROUP

  $ theresa user --help
  HELP
