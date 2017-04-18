dir
===

Synopsis
********

::

  $ theresa directory PATHNAME PREDICATE...


Predicates
**********

* `--empty`, `--non-empty`
* `--in-group GROUP`
* `--mode MODE`
* `--owned-by USER`


Examples
********

::

  $ theresa directory /var/empty --empty --owned-by root --in-group wheel --mode 755
