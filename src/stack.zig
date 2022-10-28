const zeroes = @import("std").mem.zeroes;

const CHIP8_TOTAL_STACK_DEPTH = @import("config.zig").CHIP8_TOTAL_STACK_DEPTH;

pub const Stack = struct {
    data: [CHIP8_TOTAL_STACK_DEPTH]u16 = zeroes([CHIP8_TOTAL_STACK_DEPTH]u16),
    stack_pointer: u8 = 0,

    fn isOutOfBounds(index: u16) bool {
        return index > CHIP8_TOTAL_STACK_DEPTH - 1;
    }

    pub fn push(self: *Stack, val: u16) void {
        if (isOutOfBounds(self.stack_pointer)) @panic("stack out of bounds");
        self.data[self.stack_pointer] = val;
        self.stack_pointer += 1;
    }

    pub fn pop(self: *Stack) u16 {
        self.stack_pointer -= 1;
        if (isOutOfBounds(self.stack_pointer)) @panic("stack out of bounds");
        return self.data[self.stack_pointer];
    }
};
