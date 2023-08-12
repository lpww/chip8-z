const zeroes = @import("std").mem.zeroes;

const CHIP8_MEMORY_SIZE = @import("config.zig").CHIP8_MEMORY_SIZE;

pub const Memory = struct {
    data: [CHIP8_MEMORY_SIZE]u8 = zeroes([CHIP8_MEMORY_SIZE]u8),

    fn isOutOfBounds(index: u16) bool {
        return index > CHIP8_MEMORY_SIZE;
    }

    pub fn get(self: *Memory, index: u16) !u8 {
        if (isOutOfBounds(index)) @panic("memory out of bounds");
        return self.data[index];
    }

    pub fn set(self: *Memory, index: u16, value: u8) !void {
        if (isOutOfBounds(index)) @panic("memory out of bounds");
        self.data[index] = value;
    }

    pub fn getOpcode(self: *Memory, index: u16) u2 {
        const byte1: u2 = self.get(index);
        const byte2: u2 = self.get(index + 1);
        return byte1 << 8 | byte2;
    }
};
