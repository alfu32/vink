module main

import time
import ansi_escapes

fn main() {
	t:=time.now() 
	println('[$t] Hello World!')

	println(ansi_escapes.coucou("howdy") or {
		"[$t] not ok [$err]"
	})

	println(ansi_escapes.coucou("coucou howdy") or {
		"[$t] not ok [$err]"
	})

	println(ansi_escapes.cwd_function() or {
		"[$t] cwd not working: [$err]"
	})
	println(ansi_escapes.cursor_to(44,3))
	println("[$t] ansi_escapes.cursor_to(44,3)")
	println(ansi_escapes.cursor_move(0,8))
	println("[$t] ansi_escapes.cursor_move(0,8)")
	println(ansi_escapes.cursor_move(0,-5))
	println("[$t] ansi_escapes.cursor_move(0,-5)")
}
