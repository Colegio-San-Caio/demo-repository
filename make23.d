import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;
import std.math;

void main() {
    int w = 120, h = 64;
    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            ubyte v = 0;
            // 3 stacked triangles, wider as you go down
            // layer 1: y 8-26, tip at (60,8)
            if (y >= 8 && y <= 26 && x >= 60 - (y - 8) * 1.0 && x <= 60 + (y - 8) * 1.0) v = 255;
            // layer 2: y 20-38
            if (y >= 20 && y <= 38 && x >= 60 - (y - 20) * 1.2 && x <= 60 + (y - 20) * 1.2) v = 255;
            // layer 3: y 32-50
            if (y >= 32 && y <= 50 && x >= 60 - (y - 32) * 1.4 && x <= 60 + (y - 32) * 1.4) v = 255;
            // trunk
            if (x >= 56 && x <= 64 && y >= 50 && y <= 58) v = 255;
            // star on top
            int sx = x - 60, sy = y - 6;
            if (sx < 0) sx = -sx;
            if (sy < 0) sy = -sy;
            if (sx + sy < 3) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm23.ximg", header ~ comp);
    std.file.write("rm23.raw", raw);
    writefln("made rm23.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
