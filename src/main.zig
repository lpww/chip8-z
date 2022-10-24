const std = @import("std");
const sdl = @import("sdl2");

pub fn main() !void {
    const init_code = sdl.SDL_Init(sdl.SDL_INIT_EVERYTHING);
    defer sdl.SDL_Quit();
    checkSdlErr(init_code);

    const window = sdl.SDL_CreateWindow("chip8-z window", sdl.SDL_WINDOWPOS_UNDEFINED, sdl.SDL_WINDOWPOS_UNDEFINED, 640, 320, sdl.SDL_WINDOW_SHOWN) orelse panic();
    defer sdl.SDL_DestroyWindow(window);

    while (true) {}

    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}

fn checkSdlErr(code: c_int) void {
    if (code < 0) panic();
}

fn panic() noreturn {
    const str = @as(?[*:0]const u8, sdl.SDL_GetError()) orelse "unknown error";
    @panic(std.mem.sliceTo(str, 0));
}
