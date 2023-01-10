const zeroes = @import("std").mem.zeroes;

const CHIP8_HEIGHT = @import("config.zig").CHIP8_HEIGHT;
const CHIP8_WIDTH = @import("config.zig").CHIP8_WIDTH;

pub const Screen = struct {
    pixels: [CHIP8_HEIGHT][CHIP8_WIDTH]bool = zeroes([CHIP8_HEIGHT][CHIP8_WIDTH]bool),

    fn isOutOfBounds(x: u16, y: u16) bool {
        if (x < 0 or x >= CHIP8_WIDTH) {
            // x is out of bounds
            return true;
        }

        if (y < 0 or y >= CHIP8_HEIGHT) {
            // y is out of bounds
            return true;
        }

        return false;
    }

    pub fn setPixelOn(self: *Screen, x: u16, y: u16) void {
        if (isOutOfBounds(x, y)) @panic("screen is out of bounds");
        self.pixels[y][x] = true;
    }

    pub fn isPixelOn(self: *Screen, x: u16, y: u16) bool {
        if (isOutOfBounds(x, y)) @panic("screen is out of bounds");
        return self.pixels[y][x];
    }

    pub fn drawSprite(self: *Screen, x: u16, y: u16, sprite: []const u8) bool {
        const binary_int: u512 = 0b10000000; // made this huge to accomodate right hand bit shift on line 45, better way?

        var pixel_collison = false;
        var lx: u8 = 0;

        for (sprite) |c, ly| {
            lx = 0;
            while (lx < 8) : (lx += 1) {
                if ((c & (binary_int >> lx)) == 0) {
                    continue;
                }

                const pixel_value: bool = self.pixels[(ly + y) % CHIP8_HEIGHT][(lx + x) % CHIP8_WIDTH];

                if (pixel_value) {
                    pixel_collison = true;
                }

                self.pixels[(ly + y) % CHIP8_HEIGHT][(lx + x) % CHIP8_WIDTH] = pixel_value != true;
            }
        }

        return pixel_collison;
    }
};
