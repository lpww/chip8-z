const Memory = @import("memory.zig").Memory;

pub const Chip8 = struct {
    mem: Memory = Memory{},
};
