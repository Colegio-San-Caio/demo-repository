import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;
import std.math;

void main() {
    int w = 120, h = 64;
    int cx = 60, cy = 32, r = 28;
    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            int dx = x - cx;
            int dy = y - cy;
            // inside circle = white 255, outside = black 0
            ubyte v = (dx*dx + dy*dy <= r*r) ? cast(ubyte)255 : cast(ubyte)0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm3.ximg", header ~ comp);
    std.file.write("rm3.raw", raw);
    writefln("made rm3.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
