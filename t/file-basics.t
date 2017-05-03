setup::

  $ . $TESTDIR/setup


unknown option::

  $ theresa file --omg
  theresa-file: ERROR: unknown option '--omg'
  [1]

help::

  $ theresa file -h
  theresa: usage: theresa file -h|--help
  theresa: usage: theresa file PATHNAME [PREDICATE...]
  
  Options:
  
    -h        Display this message.
  
  Predicates:
  
    --empty
    --in-group GROUP
    --mode     PERMS
    --non-empty
    --owned-by USER

  $ theresa file --help
  HELP
