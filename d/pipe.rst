pipe
====

Synopsis
********

::

  $ theresa pipe PATHNAME PREDICATE...


Predicates
**********

* `--in-group GROUP`
* `--mode MODE`
* `--owned-by USER`


Examples
********

::

  $ theresa pipe /var/service/supervise/ok --owned-by root --in-group wheel --mode 755
