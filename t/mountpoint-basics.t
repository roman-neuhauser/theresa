setup::

  $ . $TESTDIR/setup


unknown option::

  $ theresa mountpoint --omg
  theresa-mountpoint: ERROR: unknown option '--omg'
  [1]


unknown predicate::

  $ theresa mountpoint fubar --omg
  theresa-mountpoint: ERROR: unknown option '--omg'
  [1]


help::

  $ theresa mountpoint -h
  theresa: usage: theresa mountpoint -h|--help
  theresa: usage: theresa mountpoint PATHNAME [PREDICATE...]
  
  Options:
  
    -h        Display this message.
  
  Predicates:
  
    --in-group GROUP
    --mode     PERMS
    --owned-by USER

  $ theresa mountpoint --help
  HELP
