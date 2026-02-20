const std = @import("std");

extern fn hello_world(action: [*c]const u8) void;

// We use global static memory for our trap. 
// Because this test runs in a single thread and we know the string is tiny, 
var captured_output: [64]u8 = undefined;
var captured_len: usize = 0;

// Exported to the dynamic symbol table so dlsym() can find it.
// Signature must accept two pointers to perfectly map to the 
// System V ABI hardware registers used by: dynamic_eval("%s", result);
// CPU registers (RDI and RSI) that the C code will use when calling this via variadic arguments.
export fn test_capture_sink(fmt: [*c]const u8, msg: [*c]const u8) void {
    // We intentionally ignore the format string ("%s") sitting in the first register
    _ = fmt; 

    // std.mem.span walks the raw C pointer until it finds the \0 null terminator.
    // It doesn't allocate memory; it just calculates the length so we have a safe Zig slice.
    const slice = std.mem.span(msg);
    
    // Copy the raw bytes directly from the C memory space into our static Zig buffer.
    @memcpy(captured_output[0..slice.len], slice);
    captured_len = slice.len;
}

test "catfish dlsym eval" {
    // We hand our C code the name of our exported Zig function. 
    // The C code will parse its own __func__, ask the OS to find "test_capture_sink",
    // and execute it, throwing the parsed string right back into our global variables.
    hello_world("test_capture_sink");

    // Reconstruct a strict Zig string from the exact number of bytes we captured
    const result = captured_output[0..captured_len];
    
    try std.testing.expectEqualStrings("Hello World!\n", result);
}
