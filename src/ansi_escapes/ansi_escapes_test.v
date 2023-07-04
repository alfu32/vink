module ansi_escapes

pub fn test_coucou_ok() {
	println(coucou("howdy") or {
		"not ok $err"
	})
}
pub fn test_coucou_not_ok() {
	println(coucou("coucou howdy") or {
		"not ok [$err]"
	})
}

pub fn test_cursor_to(){
	print(cursor_to(10,15))
}