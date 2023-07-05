module vtml

pub fn test_color_01() {
	col := to_color(0x102030)
	println(col)
	assert col.r == 16
	assert col.g == 32
	assert col.b == 48
}
