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
            double b = ((x-56.0)*(x-56.0))/(26.0*26.0) + ((y-38.0)*(y-38.0))/(10.0*10.0);
            if (b < 1) v = 255;
            // head: circle right
            if (sqrt(cast(double)((x-84)*(x-84) + (y-36)*(y-36))) < 11) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-80)*(x-80) + (y-32)*(y-32))) < 2) v = 0;
            if (sqrt(cast(double)((x-90)*(x-90) + (y-32)*(y-32))) < 2) v = 0;
            // legs: 4 bars
            if (x >= 40 && x <= 46 && y >= 44 && y <= 54) v = 255;
            if (x >= 54 && x <= 60 && y >= 44 && y <= 54) v = 255;
            if (x >= 66 && x <= 72 && y >= 44 && y <= 54) v = 255;
            // tail: long bar left + tip
            if (x >= 12 && x <= 32 && y >= 36 && y <= 40) v = 255;
            if (sqrt(cast(double)((x-12)*(x-12) + (y-38)*(y-38))) < 3) v = 255;
            // yellow spots: black dots - salamander pattern
            if (sqrt(cast(double)((x-46)*(x-46) + (y-34)*(y-34))) < 2) v = 0;
            if (sqrt(cast(double)((x-58)*(x-58) + (y-40)*(y-40))) < 2) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-34)*(y-34))) < 2) v = 0;
            if (sqrt(cast(double)((x-76)*(x-76) + (y-40)*(y-40))) < 2) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm62.ximg", header ~ comp);
    std.file.write("rm62.raw", raw);
    writefln("made rm62.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
