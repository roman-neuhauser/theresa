setup::

  $ . $TESTDIR/setup


unknown option::

  $ theresa dir --omg
  theresa-dir: ERROR: unknown option '--omg'
  [1]

help::

  $ theresa dir -h
  theresa: usage: theresa dir -h|--help
  theresa: usage: theresa dir PATHNAME [PREDICATE...]
  
  Options:
  
    -h        Display this message.
  
  Predicates:
  
    --empty
    --in-group GROUP
    --mode     PERMS
    --non-empty
    --owned-by USER

  $ theresa dir --help
  HELP
