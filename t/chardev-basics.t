setup::

  $ . $TESTDIR/setup


unknown option::

  $ theresa chardev --omg
  theresa-chardev: ERROR: unknown option '--omg'
  [1]


unknown predicate::

  $ theresa chardev fubar --omg
  theresa-chardev: ERROR: unknown option '--omg'
  [1]


help::

  $ theresa chardev -h
  theresa: usage: theresa chardev -h|--help
  theresa: usage: theresa chardev PATHNAME [PREDICATE...]
  
  Options:
  
    -h        Display this message.
  
  Predicates:
  
    --in-group GROUP
    --mode     PERMS
    --owned-by USER

  $ theresa chardev --help
  HELP
