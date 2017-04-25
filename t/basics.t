setup::

  $ . $TESTDIR/setup


test::

  $ theresa
  theresa: usage: theresa -h
  theresa: usage: theresa THING [PREDICATE...]
  theresa: use `theresa -h` to display help

  $ theresa -h
  theresa: usage: theresa -h
  theresa: usage: theresa THING [PREDICATE...]
  
  Options:
  
    -h      Display this message.

  $ theresa -x
  theresa: error: unknown option -x
  theresa: usage: theresa -h
  theresa: usage: theresa THING [PREDICATE...]
  theresa: use `theresa -h` to display help
  [1]

  $ theresa --fubar
  theresa: error: unknown option --fubar
  theresa: usage: theresa -h
  theresa: usage: theresa THING [PREDICATE...]
  theresa: use `theresa -h` to display help
  [1]

  $ theresa snafubar
  theresa: error: cannot execute theresa-snafubar
  [111]
