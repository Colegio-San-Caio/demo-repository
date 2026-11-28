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
            // body: ellipse
            double b = ((x-60.0)*(x-60.0))/(18.0*18.0) + ((y-38.0)*(y-38.0))/(18.0*18.0);
            if (b < 1) v = 255;
            // head: circle on top
            if (sqrt(cast(double)((x-60)*(x-60) + (y-18)*(y-18))) < 10) v = 255;
            // comb: 3 bumps on top
            if (sqrt(cast(double)((x-54)*(x-54) + (y-8)*(y-8))) < 3) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-6)*(y-6))) < 3) v = 255;
            if (sqrt(cast(double)((x-66)*(x-66) + (y-8)*(y-8))) < 3) v = 255;
            // beak: triangle right
            if (x >= 68 && x <= 74 && y >= 16 && y <= 16 + (74 - x)) v = 255;
            if (x >= 68 && x <= 74 && y >= 20 && y <= 20 + (x - 68)) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-62)*(x-62) + (y-16)*(y-16))) < 2) v = 0;
            // wattle: small circle below beak
            if (sqrt(cast(double)((x-64)*(x-64) + (y-26)*(y-26))) < 3) v = 255;
            // tail: 3 feathers left
            if (x >= 38 && x <= 44 && y >= 18 && y <= 18 + (x - 38)) v = 255;
            if (x >= 36 && x <= 42 && y >= 24 && y <= 24 + (x - 36)) v = 255;
            if (x >= 38 && x <= 44 && y >= 30 && y <= 30 + (x - 38)) v = 255;
            // legs: 2 bars
            if (x >= 54 && x <= 57 && y >= 54 && y <= 60) v = 255;
            if (x >= 63 && x <= 66 && y >= 54 && y <= 60) v = 255;
            // feet: 2 small bars
            if (x >= 50 && x <= 60 && y >= 59 && y <= 61) v = 255;
            if (x >= 59 && x <= 69 && y >= 59 && y <= 61) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm44.ximg", header ~ comp);
    std.file.write("rm44.raw", raw);
    writefln("made rm44.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
