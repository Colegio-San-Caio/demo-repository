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
            // Manhattan diamond: |dx|/a + |dy|/b
            double d = abs(x - 60) / 55.0 + abs(y - 32) / 28.0;
            ubyte v = 0;
            if (d < 1.0) v = 255; // inside diamond = white
            // facet lines - inner diamond outline + cross
            if (d > 0.45 && d < 0.52) v = 0;
            if (d < 1.0 && (y == 32 || x == 60)) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm11.ximg", header ~ comp);
    std.file.write("rm11.raw", raw);
    writefln("made rm11.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
