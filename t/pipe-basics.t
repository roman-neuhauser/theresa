setup::

  $ . $TESTDIR/setup


unknown option::

  $ theresa pipe --omg
  theresa-pipe: ERROR: unknown option '--omg'
  [1]

help::

  $ theresa pipe -h
  theresa: usage: theresa pipe -h|--help
  theresa: usage: theresa pipe PATHNAME [PREDICATE...]
  
  Options:
  
    -h        Display this message.
  
  Predicates:
  
    --in-group GROUP
    --mode     PERMS
    --owned-by USER

  $ theresa pipe --help
  HELP
