const m = @import("memory.zig");

pub const Chip8 = struct {
    mem: m.Memory = m.Memory{},
};
