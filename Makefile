.PHONY: build test test.watch

build:
	bundle install

test:
	bundle exec rake spec

test.watch:
	ls -1 $(find lib spec -name '*rb') | entr -r make test
