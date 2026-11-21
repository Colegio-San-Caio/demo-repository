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
            // shaft: horizontal bar
            if (x >= 20 && x <= 70 && y >= 28 && y <= 36) v = 255;
            // head: triangle, tip at (95,32)
            if (x >= 70 && x <= 95) {
                double dy = y - 32;
                if (dy < 0) dy = -dy;
                if (dy <= (95 - x) * 0.8) v = 255;
            }
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm19.ximg", header ~ comp);
    std.file.write("rm19.raw", raw);
    writefln("made rm19.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
