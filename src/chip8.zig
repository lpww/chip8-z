const mem = @import("std").mem;
const Keyboard = @import("keyboard.zig").Keyboard;
const Memory = @import("memory.zig").Memory;
const Registers = @import("registers.zig").Registers;
const Screen = @import("screen.zig").Screen;
const Stack = @import("stack.zig").Stack;

const CHIP8_PROGRAM_LOAD_ADDRESS = @import("config.zig").CHIP8_PROGRAM_LOAD_ADDRESS;

const chip8_default_character_set = [80]u8{
    0xf0, 0x90, 0x90, 0x90, 0xf0, // "0"
    0x20, 0x60, 0x20, 0x20, 0x70, // "1"
    0xf0, 0x10, 0xf0, 0x80, 0xf0, // "2"
    0xf0, 0x10, 0xf0, 0x10, 0xf0, // "3"
    0x90, 0x90, 0xf0, 0x10, 0x10, // "4"
    0xf0, 0x80, 0xf0, 0x10, 0xf0, // "5"
    0xf0, 0x80, 0xf0, 0x90, 0xf0, // "6"
    0xf0, 0x10, 0x20, 0x40, 0x40, // "7"
    0xf0, 0x90, 0xf0, 0x90, 0xf0, // "8"
    0xf0, 0x90, 0xf0, 0x10, 0xf0, // "9"
    0xf0, 0x90, 0xf0, 0x90, 0x90, // "A"
    0xe0, 0x90, 0xe0, 0x90, 0xe0, // "B"
    0xf0, 0x80, 0x80, 0x80, 0xf0, // "C"
    0xe0, 0x90, 0x90, 0x90, 0xe0, // "D"
    0xf0, 0x80, 0xf0, 0x80, 0xf0, // "E"
    0xf0, 0x80, 0xf0, 0x80, 0x80, // "F"
};

pub const Chip8 = struct {
    keyboard: Keyboard = Keyboard{},
    mem: Memory = Memory{},
    reg: Registers = Registers{},
    screen: Screen = Screen{},
    stack: Stack = Stack{},

    pub fn init() Chip8 {
        var c8 = Chip8{};
        mem.copy(u8, &c8.mem.data, &chip8_default_character_set);
        return c8;
    }

    pub fn load(self: *Chip8, buf: *[]const u8, size: u8) void {
        mem.copy(u8, &self.mem.data[CHIP8_PROGRAM_LOAD_ADDRESS..size], &buf);
        self.registers.program_counter = CHIP8_PROGRAM_LOAD_ADDRESS;
    }

    // pub fn exec(self: *Chip8, opcode: u2) void {
    // }
};
