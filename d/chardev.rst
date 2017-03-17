chardev
=======

Synopsis
********

::

  $ theresa chardev PATHNAME PREDICATE...


Predicates
**********

* `--in-group GROUP`
* `--mode MODE`
* `--owned-by USER`


Examples
********

::

  $ theresa chardev /dev/zero \
    --owned-by root \
    --in-group wheel \
    --mode 666
