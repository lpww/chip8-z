const std = @import("std");
const sdl = @import("sdl2");

const config = @import("config.zig");
const c = @import("chip8.zig");

pub fn main() !void {
    var chip = c.Chip8{};
    const in = 'z';
    try chip.mem.set(500, in);
    const out = chip.mem.get(500);
    std.debug.print("All your {u} are belong to us.\n", .{out});

    try sdl.init(sdl.InitFlags.everything);
    defer sdl.quit();

    const window = try sdl.createWindow(
        config.INTERPRETER_WiNDOW_TITLE,
        .{ .centered = {} },
        .{ .centered = {} },
        config.CHIP8_SCALED_WIDTH,
        config.CHIP8_SCALED_HEIGHT,
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

    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}
