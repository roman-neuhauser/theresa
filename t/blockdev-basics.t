setup::

  $ . $TESTDIR/setup


unknown option::

  $ theresa blockdev --omg
  theresa-blockdev: ERROR: unknown option '--omg'
  [1]


unknown predicate::

  $ theresa blockdev fubar --omg
  theresa-blockdev: ERROR: unknown option '--omg'
  [1]


help::

  $ theresa blockdev -h
  theresa: usage: theresa blockdev -h|--help
  theresa: usage: theresa blockdev PATHNAME [PREDICATE...]
  
  Options:
  
    -h        Display this message.
  
  Predicates:
  
    --in-group GROUP
    --mode     PERMS
    --owned-by USER

  $ theresa blockdev --help
  HELP
