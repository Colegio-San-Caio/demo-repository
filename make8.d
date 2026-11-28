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
            // 3 sine waves
            double w1 = 16 + 10 * sin(x * 0.12);
            double w2 = 32 + 10 * sin(x * 0.12 + 2.0);
            double w3 = 48 + 10 * sin(x * 0.12 + 4.0);
            ubyte v = 0;
            if (abs(y - w1) < 1.5) v = 255;
            if (abs(y - w2) < 1.5) v = 255;
            if (abs(y - w3) < 1.5) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm8.ximg", header ~ comp);
    std.file.write("rm8.raw", raw);
    writefln("made rm8.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
