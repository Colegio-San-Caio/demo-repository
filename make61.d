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
            double b = ((x-56.0)*(x-56.0))/(24.0*24.0) + ((y-38.0)*(y-38.0))/(10.0*10.0);
            if (b < 1) v = 255;
            // head: wide circle right
            if (sqrt(cast(double)((x-82)*(x-82) + (y-36)*(y-36))) < 12) v = 255;
            // gills: 3 small bars each side - feathery
            if (x >= 68 && x <= 74 && y >= 22 && y <= 26) v = 255;
            if (x >= 68 && x <= 74 && y >= 28 && y <= 32) v = 255;
            if (x >= 68 && x <= 74 && y >= 34 && y <= 38) v = 255;
            if (x >= 88 && x <= 94 && y >= 22 && y <= 26) v = 255;
            if (x >= 88 && x <= 94 && y >= 28 && y <= 32) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-78)*(x-78) + (y-30)*(y-30))) < 2) v = 0;
            if (sqrt(cast(double)((x-88)*(x-88) + (y-30)*(y-30))) < 2) v = 0;
            // smile: small bar
            if (x >= 80 && x <= 88 && y >= 40 && y <= 42) v = 0;
            // legs: 4 small bars
            if (x >= 40 && x <= 45 && y >= 46 && y <= 54) v = 255;
            if (x >= 54 && x <= 59 && y >= 46 && y <= 54) v = 255;
            if (x >= 66 && x <= 71 && y >= 46 && y <= 54) v = 255;
            // tail: fin - triangle left
            if (x >= 14 && x <= 32 && y >= 34 && y <= 34 + (32 - x)) v = 255;
            if (x >= 14 && x <= 32 && y >= 38 - (32 - x) && y <= 38) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm61.ximg", header ~ comp);
    std.file.write("rm61.raw", raw);
    writefln("made rm61.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
