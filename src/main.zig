const std = @import("std");
const sdl = @import("sdl2");

pub fn main() !void {
    try sdl.init(sdl.InitFlags.everything);
    defer sdl.quit();

    const window = try sdl.createWindow(
        "chip-z window",
        .{ .centered = {} },
        .{ .centered = {} },
        640,
        320,
        .{ .vis = .shown },
    );
    defer window.destroy();

    const renderer = try sdl.createRenderer(window, null, .{ .target_texture = true });
    defer renderer.destroy();

    while (true) {
        try renderer.setColorRGBA(0, 0, 0, 0);
        try renderer.clear();
    }

    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}
