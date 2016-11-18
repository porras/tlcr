all: tlcr

tlcr: tlcr.cr src/**/*.cr
	shards
	crystal build --release tlcr.cr
	@du -sh tlcr

clean:
	rm -rf .crystal tlcr .deps .shards libs

PREFIX ?= /usr/local

install: tlcr
	install -d $(PREFIX)/bin
	install tlcr $(PREFIX)/bin
