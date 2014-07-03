install: symlink
	npm install && bower install

symlink:
	ln -s ../bower_components/closure-library/closure/goog var/goog
