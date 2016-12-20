rst  = README.rst
rst += d/blockdev.rst
rst += d/chardev.rst
rst += d/dir.rst
rst += d/file.rst
rst += d/mountpoint.rst
rst += d/pipe.rst
rst += d/symlink.rst
rst += d/user.rst

html = $(addsuffix .html,$(basename $(rst)))

.PHONY: html
html: $(html)
$(html): %.html: %.rst
	rst2html --strict $< $@


.PHONY: clean
clean:
	$(RM) $(html)
