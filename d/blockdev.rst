blockdev
========

Synopsis
********

::

  $ theresa blockdev PATHNAME PREDICATE...


Predicates
**********

* `--in-group GROUP`
* `--mode MODE`
* `--owned-by USER`


Examples
********

::

  $ theresa blockdev /dev/sda --owned-by root --in-group disk --mode 660
