module vtml

import math

pub struct Box {
pub mut:
	top    i32
	right  i32
	bottom i32
	left   i32
}

fn (b Box) add(box Box) Box {
	return Box{
		top: math.min(b.top, box.top)
		right: math.max(b.right, box.right)
		bottom: math.max(b.bottom, box.bottom)
		left: math.min(b.left, box.left)
	}
}

fn (b Box) pad(padding i32) Box {
	return Box{
		top: math.min(b.top - padding, b.bottom + padding)
		right: math.max(b.right + padding, b.left - padding)
		bottom: math.max(b.top - padding, b.bottom + padding)
		left: math.min(b.right + padding, b.left - padding)
	}
}
