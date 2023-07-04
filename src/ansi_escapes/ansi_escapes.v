module ansi_escapes

import os

pub fn coucou(s string) !string {
	return if s.contains("coucou") {
		error("no coucou allowed in '$s'")
	} else {
		"$s coucou"
	}
}


const esc = '\u001B['
const osc = '\u001B]'
const bel = '\u0007'
const sep = ';'

fn is_browser() bool { return false}

const is_terminal_app = true
pub fn is_windows() bool {
	$if windows {
		return true
	} $else {
		return false
	}
}

pub fn cwd_function() !string {
	$if false {
			return error('`os.getwd()` does not work in browser.')
	} $else {
			return os.getwd()
	}
}

pub fn cursor_to (x i64, y i64) string {
	return "${esc}${(y + 1)}${sep}${(x + 1)}H"
}
pub fn cursor_move(x i64, y i64) string {

	mut return_value := ''

	if x < 0 {
		return_value += "${esc}${-x}D"
	} else if x > 0 {
		return_value += "${esc}${x}C"
	}

	if y < 0 {
		return_value += "${esc}${-y}A"
	} else if y > 0 {
		return_value +="${esc}${y}B"
	}

	return return_value
}