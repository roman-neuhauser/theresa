setup::

  $ . $TESTDIR/setup


unknown option::

  $ theresa symlink --omg
  theresa-symlink: ERROR: unknown option '--omg'
  [1]

help::

  $ theresa symlink -h
  theresa: usage: theresa symlink -h|--help
  theresa: usage: theresa symlink PATHNAME [PREDICATE...]
  
  Options:
  
    -h        Display this message.
  
  Predicates:
  
    --in-group GROUP
    --mode     PERMS
    --owned-by USER
    --to       PATHNAME

  $ theresa symlink --help
  HELP
