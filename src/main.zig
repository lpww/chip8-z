const debug = @import("std").debug;
const sdl = @import("sdl2");

const conf = @import("config.zig");
const Chip8 = @import("chip8.zig").Chip8;
const mapKeys = @import("keyboard.zig").mapKeys;

const virtual_keys = [conf.CHIP8_TOTAL_KEYS]u32{ sdl.c.SDLK_0, sdl.c.SDLK_1, sdl.c.SDLK_2, sdl.c.SDLK_3, sdl.c.SDLK_4, sdl.c.SDLK_5, sdl.c.SDLK_6, sdl.c.SDLK_7, sdl.c.SDLK_8, sdl.c.SDLK_9, sdl.c.SDLK_a, sdl.c.SDLK_b, sdl.c.SDLK_c, sdl.c.SDLK_d, sdl.c.SDLK_e, sdl.c.SDLK_f };

pub fn main() !void {
    var c8 = Chip8{};

    try sdl.init(sdl.InitFlags.everything);
    defer sdl.quit();

    const window = try sdl.createWindow(
        conf.INTERPRETER_WiNDOW_TITLE,
        .{ .centered = {} },
        .{ .centered = {} },
        conf.CHIP8_SCALED_WIDTH,
        conf.CHIP8_SCALED_HEIGHT,
        .{ .vis = .shown },
    );
    defer window.destroy();

    const renderer = try sdl.createRenderer(window, null, .{ .target_texture = true });
    defer renderer.destroy();

    main_loop: while (true) {

        // poll sdl events
        while (sdl.pollEvent()) |event| {
            switch (event) {
                .quit => break :main_loop, // break the main loop
                .key_down => |kev| {
                    const key = @intCast(u32, @enumToInt(kev.keycode));
                    debug.print("keyboard_keycode: {X}\n", .{key});
                    const vkey = mapKeys(virtual_keys, key);
                    debug.print("virtual_keycode: {X}\n", .{vkey});
                    if (vkey != -1) {
                        c8.keyboard.down(vkey);
                    }
                },
                .key_up => |kev| {
                    const key = @intCast(u32, @enumToInt(kev.keycode));
                    debug.print("keyboard_keycode: {X}\n", .{key});
                    const vkey = mapKeys(virtual_keys, key);
                    debug.print("virtual_keycode: {X}\n", .{vkey});
                    if (vkey != -1) {
                        c8.keyboard.up(vkey);
                    }
                },
                else => {},
            }
        }

        try renderer.setColorRGBA(0, 0, 0, 0); // set color to black
        try renderer.clear(); // clear the screen with color

        // 40x40 rectangle
        const r = sdl.Rectangle{
            .x = 0,
            .y = 0,
            .width = 40,
            .height = 40,
        };

        try renderer.setColorRGBA(255, 255, 255, 0); // set color to white
        try renderer.fillRect(r); // fill rectangle with color
        renderer.present();
    }

    debug.print("All your {s} are belong to us.\n", .{"codebase"});
}
