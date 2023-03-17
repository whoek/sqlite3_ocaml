# sqlite3_ocaml

Simple sqlite3 program in OCaml

```
dune build

dune exec ./bin/main.exe

```
This will create a database file `test.db`

```
$ ldd main.exe 
	linux-vdso.so.1 (0x00007ffffd98b000)
	libsqlite3.so.0 => /lib/x86_64-linux-gnu/libsqlite3.so.0 (0x00007fad9919b000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fad99178000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fad99029000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fad99023000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fad98e31000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fad993ec000)

```
