const debug = @import("std").debug;
const heap = @import("std").heap;
const process = @import("std").process;
const time = @import("std").time;
const sdl = @import("sdl2");

const conf = @import("config.zig");
const Chip8 = @import("chip8.zig").Chip8;
const mapKeys = @import("keyboard.zig").mapKeys;

const virtual_keys = [conf.CHIP8_TOTAL_KEYS]u32{ sdl.c.SDLK_0, sdl.c.SDLK_1, sdl.c.SDLK_2, sdl.c.SDLK_3, sdl.c.SDLK_4, sdl.c.SDLK_5, sdl.c.SDLK_6, sdl.c.SDLK_7, sdl.c.SDLK_8, sdl.c.SDLK_9, sdl.c.SDLK_a, sdl.c.SDLK_b, sdl.c.SDLK_c, sdl.c.SDLK_d, sdl.c.SDLK_e, sdl.c.SDLK_f };

pub fn main() !void {
    var gpa = heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try process.argsAlloc(allocator);
    defer process.argsFree(allocator, args);
    debug.print("Arguments: {s}\n", .{args});

    // todo: open file and load it into memory

    var c8 = Chip8.init();

    c8.reg.delay_timer = 255;

    var is_collison: bool = c8.screen.drawSprite(62, 10, c8.mem.data[0..5]);
    debug.print("Collison detected: {d}.\n", .{@boolToInt(is_collison)});

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
                    const vkey = mapKeys(virtual_keys, key);
                    if (vkey != -1) {
                        c8.keyboard.down(vkey);
                    }
                },
                .key_up => |kev| {
                    const key = @intCast(u32, @enumToInt(kev.keycode));
                    const vkey = mapKeys(virtual_keys, key);
                    if (vkey != -1) {
                        c8.keyboard.up(vkey);
                    }
                },
                else => {},
            }
        }

        try renderer.setColorRGBA(0, 0, 0, 0); // set color to black
        try renderer.clear(); // clear the screen with color
        try renderer.setColorRGBA(255, 255, 255, 0); // set color to white

        for (c8.screen.pixels) |row, y| {
            for (row) |pixel_is_on, x| {
                if (pixel_is_on) {
                    const r = sdl.Rectangle{
                        .x = @intCast(c_int, x) * conf.CHIP8_SCALE_FACTOR,
                        .y = @intCast(c_int, y) * conf.CHIP8_SCALE_FACTOR,
                        .width = conf.CHIP8_SCALE_FACTOR,
                        .height = conf.CHIP8_SCALE_FACTOR,
                    };

                    try renderer.fillRect(r); // fill rectangle with color
                }
            }
        }

        renderer.present();

        if (c8.reg.delay_timer > 0) {
            time.sleep(100 / 1000);
            c8.reg.delay_timer -= 1;
        }
    }

    debug.print("All your {s} are belong to us.\n", .{"codebase"});
}
