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
            // ears: 2 triangles
            if (x >= 38 && x <= 52 && y >= 8 + (x - 38) * 0.8 && y <= 24) v = 255;
            if (x >= 68 && x <= 82 && y >= 8 + (82 - x) * 0.8 && y <= 24) v = 255;
            // head: circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 20) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-52)*(x-52) + (y-30)*(y-30))) < 2.5) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-30)*(y-30))) < 2.5) v = 0;
            // nose: small triangle
            if (x >= 58 && x <= 62 && y >= 36 && y <= 36 + (2 - abs(x - 60)) * 2) v = 0;
            // mouth: 2 small arcs cut out
            if (sqrt(cast(double)((x-56)*(x-56) + (y-40)*(y-40))) < 3 && y >= 40 && x < 60) v = 0;
            if (sqrt(cast(double)((x-64)*(x-64) + (y-40)*(y-40))) < 3 && y >= 40 && x > 60) v = 0;
            // whiskers: 3 lines each side cut out
            if (y == 32 && x >= 30 && x <= 42) v = 0;
            if (y == 36 && x >= 30 && x <= 42) v = 0;
            if (y == 40 && x >= 32 && x <= 42) v = 0;
            if (y == 32 && x >= 78 && x <= 90) v = 0;
            if (y == 36 && x >= 78 && x <= 90) v = 0;
            if (y == 40 && x >= 78 && x <= 88) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm30.ximg", header ~ comp);
    std.file.write("rm30.raw", raw);
    writefln("made rm30.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
