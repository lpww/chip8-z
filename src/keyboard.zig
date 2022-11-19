const zeroes = @import("std").mem.zeroes;

const CHIP8_TOTAL_KEYS = @import("config.zig").CHIP8_TOTAL_KEYS;

pub const Keyboard = struct {
    data: [CHIP8_TOTAL_KEYS]bool = zeroes([CHIP8_TOTAL_KEYS]bool),

    fn isOutOfBounds(index: usize) bool {
        return index > CHIP8_TOTAL_KEYS - 1;
    }

    pub fn down(self: *Keyboard, key: isize) void {
        const index: usize = @bitCast(usize, key);
        if (isOutOfBounds(index)) @panic("keyboard is out of bounds");
        self.data[index] = true;
    }

    pub fn up(self: *Keyboard, key: isize) void {
        const index: usize = @bitCast(usize, key);
        if (isOutOfBounds(index)) @panic("keyboard is out of bounds");
        self.data[index] = false;
    }

    pub fn isPressed(self: *Keyboard, key: isize) bool {
        const index: usize = @bitCast(usize, key);
        if (isOutOfBounds(index)) @panic("keyboard is out of bounds");
        return self.data[index];
    }
};

pub fn mapKeys(map: [CHIP8_TOTAL_KEYS]u32, keyboard_key: u32) isize {
    for (map) |chip8_key, i| {
        if (chip8_key == keyboard_key) {
            return @bitCast(isize, i);
        }
    }

    return -1;
}
