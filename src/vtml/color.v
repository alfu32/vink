module vtml

import term.ui

pub fn to_color(u u32) ui.Color {
	return ui.Color{
		r: u8((u & 0xff0000) >> 16)
		g: u8((u & 0x00ff00) >> 8)
		b: u8(u & 0x0000ff)
	}
}
