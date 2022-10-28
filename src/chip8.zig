const Memory = @import("memory.zig").Memory;
const Registers = @import("registers.zig").Registers;
const Stack = @import("stack.zig").Stack;

pub const Chip8 = struct {
    mem: Memory = Memory{},
    reg: Registers = Registers{},
    stack: Stack = Stack{},
};
