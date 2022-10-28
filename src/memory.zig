const mem = @import("std").mem;

const CHIP8_MEMORY_SIZE = @import("config.zig").CHIP8_MEMORY_SIZE;

pub const Memory = struct {
    data: [CHIP8_MEMORY_SIZE]u8 = mem.zeroes([CHIP8_MEMORY_SIZE]u8),

    pub fn get(self: *Memory, index: u16) u8 {
        return self.data[index];
    }

    pub fn set(self: *Memory, index: u16, value: u8) !void {
        self.data[index] = value;
    }
};
