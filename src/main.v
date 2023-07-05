module main

import time
import ansi_escapes
import term
import os
import term.ui
import vtml
import vxml

fn main2() {
	term.clear() // clears the content in the terminal
	width, height := term.get_terminal_size() // get the size of the terminal
	term.set_cursor_position(x: width / 2, y: height / 2) // now we point the cursor to the middle of  the terminal
	println(term.strikethrough(term.bright_green('hello world'))) // Print green text
	term.set_cursor_position(x: 0, y: height) // Sets the position of the cursor to the bottom of the terminal
	// Keep prompting until the user presses the q key
	for {
		if var := os.input_opt('press q to quit: ') {
			if var != 'q' {
				continue
			}
			break
		}
		println('')
		break
	}
	println('Goodbye.')
}

struct App {
mut:
	tui      &ui.Context = unsafe { nil }
	document vtml.HtmlProxy
}

fn event(e &ui.Event, x voidptr) {
	if e.typ == .key_down && e.code == .escape {
		exit(0)
	}
}

fn main() {
	//// t:=time.now()
	//// println('[$t] Hello World!')
	////
	//// println(ansi_escapes.coucou("howdy") or {
	//// 	"[$t] not ok [$err]"
	//// })
	////
	//// println(ansi_escapes.coucou("coucou howdy") or {
	//// 	"[$t] not ok [$err]"
	//// })
	////
	//// println(ansi_escapes.cwd_function() or {
	//// 	"[$t] cwd not working: [$err]"
	//// })
	//// println(ansi_escapes.cursor_to(44,3))
	//// println("[$t] ansi_escapes.cursor_to(44,3)")
	//// println(ansi_escapes.cursor_move(0,8))
	//// println("[$t] ansi_escapes.cursor_move(0,8)")
	//// println(ansi_escapes.cursor_move(0,-5))
	//// println("[$t] ansi_escapes.cursor_move(0,-5)")
	//// main2()
	////
	//// mut app := &App{}
	//// app.tui = tui.init(
	//// 	user_data: app
	//// 	event_fn: event
	//// 	frame_fn: frame
	//// 	hide_cursor: true
	//// )
	//// app.tui.run()!
	mut app := &App{}
	app.tui = ui.init(
		user_data: app
		event_fn: event
		frame_fn: frame
		hide_cursor: true
	)
	app.document = vtml.html_proxy_from_html('
	<time bg_color="0xffffff" color="0x332211" class="title" top="0" left="0" bottom="64" right="120"></time>
	<div bg_color="0xffffff" color="0x332211" class="layout" top="0" left="0" bottom="64" right="120">
		<component bg_color="0xffffff" color="0x332211" class="title" top="0" left="0" bottom="64" right="120">
			some text
		</component>
	</div>
	<component bg_color="0xffffff" color="0x332211" class="title" top="0" left="0" bottom="64" right="120">
	    <div bg_color="0xffffff" color="0x332211" class="layout" top="0" left="0" bottom="64" right="120">some text</div>
	</component>
	'.trim_indent())
	// app.document = vtml.html_proxy_from_html('
	// <time bg_color="0xffffff" color="0x332211" class="title" top="0" left="0" bottom="64" right="120"></time>
	// '.trim_indent())

	app.tui.run()!
}

fn frame(x voidptr) {
	t := time.now()
	mut app := &App(x)

	app.tui.clear()
	mut tt := app.document.node.get_element_by_tag_name('time') or { panic('time not found') }
	tt.text = 'TIME IS ${t}'
	app.document.render(mut app.tui)
	app.tui.set_cursor_position(0, 0)

	app.tui.reset()
	app.tui.flush()
}

fn frame2(x voidptr) {
	mut app := &App(x)

	app.tui.clear()
	app.tui.set_bg_color(r: 63, g: 81, b: 181)
	app.tui.draw_rect(20, 6, 41, 10)
	app.tui.draw_text(24, 8, 'Hello from V!')
	app.tui.set_cursor_position(0, 0)

	app.tui.reset()
	app.tui.flush()
}
