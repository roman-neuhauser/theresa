setup::

  $ . $TESTDIR/setup


unknown option::

  $ theresa group --omg
  theresa-group: ERROR: unknown option '--omg'
  [1]

help::

  $ theresa group -h
  theresa: usage: theresa group -h|--help
  theresa: usage: theresa group NAME [PREDICATE...]
  
  Options:
  
    -h        Display this message.
  
  Predicates:
  
    --not-password-protected
    --password-protected
    --with-member USER

  $ theresa group --help
  HELP
