nocross=yes
make_check=no
do_check() { :; }

do_build() {
	export VERGEN_IDEMPOTENT=1 CARGO_TERM_COLOR=never
	if [ -f justfile ] || [ -f Justfile ]; then
		just build-release
	elif [ -f Makefile ]; then
		make ${makejobs}
	else
		cargo build --release --locked
	fi
}

do_install() {
	if [ -f justfile ] || [ -f Justfile ]; then
		just rootdir=${DESTDIR} prefix=/usr install
	elif [ -f Makefile ]; then
		make DESTDIR=${DESTDIR} prefix=/usr install
	else
		for b in target/release/*; do [ -f "$b" ] && [ -x "$b" ] && vbin "$b"; done
	fi
}
