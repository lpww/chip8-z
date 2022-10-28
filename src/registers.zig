const zeroes = @import("std").mem.zeroes;

const CHIP8_TOTAL_DATA_REGISTERS = @import("config.zig").CHIP8_TOTAL_DATA_REGISTERS;

pub const Registers = struct {
    V: [CHIP8_TOTAL_DATA_REGISTERS]u8 = zeroes([CHIP8_TOTAL_DATA_REGISTERS]u8),
    I: u16 = 0,
    delay_timer: u8 = 0,
    sound_timer: u8 = 0,
    program_counter: u16 = 0,
    stack_pointer: u8 = 0,
};
