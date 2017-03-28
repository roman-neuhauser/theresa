setup::

  $ . $TESTDIR/setup


test::

  $ theresa
  theresa: usage: theresa -h|-hh
  theresa: usage: theresa THING [PREDICATE...]
  theresa: use `theresa -hh` to display help

  $ theresa -h
  theresa: usage: theresa -h|-hh
  theresa: usage: theresa THING [PREDICATE...]
  theresa: use `theresa -hh` to display help

  $ theresa -hh
  theresa: usage: theresa -h|-hh
  theresa: usage: theresa THING [PREDICATE...]
  
  Options:
  
    -h      Display short usage help.
            Given twice, display full help.

  $ theresa -x
  theresa: error: unknown option -x
  theresa: usage: theresa -h|-hh
  theresa: usage: theresa THING [PREDICATE...]
  theresa: use `theresa -hh` to display help
  [1]

  $ theresa snafubar
  theresa: error: cannot execute theresa-snafubar
  [111]
