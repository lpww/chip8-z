const zeroes = @import("std").mem.zeroes;

const CHIP8_MEMORY_SIZE = @import("config.zig").CHIP8_MEMORY_SIZE;

pub const Memory = struct {
    data: [CHIP8_MEMORY_SIZE]u8 = zeroes([CHIP8_MEMORY_SIZE]u8),

    fn indexOutOfBounds(index: u16) bool {
        return index < 0 and index < CHIP8_MEMORY_SIZE;
    }

    pub fn get(self: *Memory, index: u16) u8 {
        if (indexOutOfBounds(index)) @panic("out of bounds");
        return self.data[index];
    }

    pub fn set(self: *Memory, index: u16, value: u8) !void {
        if (indexOutOfBounds(index)) @panic("out of bounds");
        self.data[index] = value;
    }
};
