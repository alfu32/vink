module vtml

import vxml
import arrays
import term.ui
import strconv
import regex

pub struct HtmlProxy {
pub mut:
	node vxml.Node
	html string
}

pub fn html_proxy_from_html(html string) HtmlProxy {
	mut node := vxml.parse(html)
	return HtmlProxy{
		node: node
		html: html
	}
}

pub fn html_proxy_from_node(node vxml.Node) HtmlProxy {
	mut outer_html := node_to_string(node).trim('\n\t\s ')
	return HtmlProxy{
		node: node
		html: outer_html
	}
}

fn get_box(node &vxml.Node) Box {
	return Box{
		top: strconv.atoi(node.attributes['top'] or { '0' }) or { 0 }
		right: strconv.atoi(node.attributes['right'] or { '0' }) or { 0 }
		bottom: strconv.atoi(node.attributes['bottom'] or { '0' }) or { 0 }
		left: strconv.atoi(node.attributes['left'] or { '0' }) or { 0 }
	}
}

fn node_to_string(node vxml.Node) string {
	mut attrs := []string{}
	for attrn, attrv in node.attributes {
		attrs << '${attrn}="${attrv}"'
	}
	mut children := [node.text]
	for child in node.children {
		children << node_to_string(child)
	}
	return '<${node.name} ${attrs.join(' ')}>${children.join('')}</${node.name}>'
}

fn (this HtmlProxy) children() []HtmlProxy {
	return this.node.children.map(fn (n &vxml.Node) HtmlProxy {
		return html_proxy_from_node(n)
	})
}

fn (this HtmlProxy) attributes() map[string]string {
	return this.node.attributes
}

fn (this HtmlProxy) inner_html() !string {
	mut regex_start := regex.regex_opt('^<${this.node.name}.*>') or {
		a, _, _ := regex.regex_base('^<${this.node.name}.*>')
		a
	}
	mut regex_end := regex.regex_opt('</${this.node.name}>$')!
	mut str := this.html
	str = regex_start.replace_simple(str, '')
	str = regex_end.replace_simple(str, '')
	/// mut str:=this.html.trim_indent().all_after_first(">")
	/// mut regex_end := regex.regex_opt('</${this.node.name}>$')!
	/// str = regex_end.replace_simple( str,'')
	return str
}

fn (this HtmlProxy) is_terminal() bool {
	return this.node.children.len == 0
}

fn (this HtmlProxy) is_root() bool {
	return this.node.is_root()
}

fn (this HtmlProxy) box() Box {
	if this.is_terminal() {
		return Box{
			top: 0
			right: 0
			bottom: 0
			left: this.node.text.len
		}.pad(1)
	} else {
		return arrays.fold[&vxml.Node, Box](this.node.children, Box{
			top: 0
			right: 0
			bottom: 0
			left: this.node.text.len
		}.pad(1), fn (acc Box, n &vxml.Node) Box {
			return acc.add(get_box(n).pad(1))
		})
	}
}

pub fn to_color(u u32) ui.Color {
	return ui.Color{
		r: u8((u & 0xff0000) >> 4)
		g: u8(u & 0x00ff00) >> 2
		b: u8(u & 0x0000ff)
	}
}

pub fn (this HtmlProxy) render_at(mut ctx ui.Context, refx i32, refy i32) {
	bx := this.box()
	ctx.set_bg_color(to_color((this.node.attributes['bg_color'] or { '0' }).u32()))
	ctx.set_color(to_color((this.node.attributes['color'] or { '0' }).u32()))
	ctx.draw_rect(refx + bx.left, refy + bx.top, refx + bx.right, refy + bx.bottom)
	for child in this.node.children {
		html_proxy_from_node(child).render_at(mut ctx, refx + bx.left, refy + bx.top)
	}
	ctx.draw_text(refx + bx.left, refy + bx.top, this.node.text)
	if this.node.is_root() {
		ctx.flush()
	}
}

pub fn (this HtmlProxy) render(mut ctx ui.Context) {
	this.render_at(mut ctx, 0, 0)
}
