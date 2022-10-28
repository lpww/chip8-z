const Memory = @import("memory.zig").Memory;
const Registers = @import("registers.zig").Registers;

pub const Chip8 = struct {
    mem: Memory = Memory{},
    reg: Registers = Registers{},
};
