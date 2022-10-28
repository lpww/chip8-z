const std = @import("std");

const config = @import("config.zig");

pub const Memory = struct {
    data: [config.CHIP8_MEMORY_SIZE]u8 = std.mem.zeroes([config.CHIP8_MEMORY_SIZE]u8),

    pub fn get(self: *Memory, index: u16) u8 {
        return self.data[index];
    }

    pub fn set(self: *Memory, index: u16, value: u8) !void {
        self.data[index] = value;
    }
};
