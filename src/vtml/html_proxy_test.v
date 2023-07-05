module vtml

pub fn test_html_proxy_from_html() {
	n := html_proxy_from_html('
	<div bg_color="0xffffff" color="0x332211" class="layout" top="0" left="0" bottom="64" right="120">
		<component bg_color="0xffffff" color="0x332211" class="title" top="0" left="0" bottom="64" right="120">
			some text
		</component>
	</div>
	'.trim_indent())

	println('------- n -------------------------------------------------------------')
	println(n)
}

pub fn test_html_proxy_from_html_without_root() {
	n := html_proxy_from_html('
	<div bg_color="0xffffff" color="0x332211" class="layout" top="0" left="0" bottom="64" right="120">
		<component bg_color="0xffffff" color="0x332211" class="title" top="0" left="0" bottom="64" right="120">
			some text
		</component>
	</div>
	<component bg_color="0xffffff" color="0x332211" class="title" top="0" left="0" bottom="64" right="120">
	    <div bg_color="0xffffff" color="0x332211" class="layout" top="0" left="0" bottom="64" right="120">some text</div>
	</component>
	'.trim_indent())

	println('------- n -------------------------------------------------------------')
	println(n)
	println(n.children())
}

pub fn test_html_proxy_from_node() {
	n := html_proxy_from_html('
	<div bg_color="0xffffff" color="0x332211" class="layout" top="0" left="0" bottom="64" right="120">
		<component bg_color="0xffffff" color="0x332211" class="title" top="0" left="0" bottom="64" right="120">
			some text
		</component>
	</div>
	'.trim_indent())

	println('------- n ----------------------------------------------------------------')
	println(n)
	println('------- n.children()[0] --------------------------------------------------')
	println(n.children()[0])
	println('------- n.children()[0].children()[0] ------------------------------------')
	println(n.children()[0].children()[0])
}

pub fn test_inner_html() {
	n := html_proxy_from_html('
	<div bg_color="0xffffff" color="0x332211" class="layout" top="0" left="0" bottom="64" right="120">
		<component bg_color="0xffffff" color="0x332211" class="title" top="0" left="0" bottom="64" right="120">
			some text
		</component>
	</div>
	'.trim_indent())

	println('------- n.inner_html()! --------------------------------')
	println(n.inner_html()!)
	println('------- n.children()[0].inner_html()! ------------------')
	println(n.children()[0].inner_html()!)
	println('------- n.children()[0].children()[0].inner_html()! ----')
	println(n.children()[0].children()[0].inner_html()!)
}
