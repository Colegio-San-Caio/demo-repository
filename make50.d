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
            double b = ((x-56.0)*(x-56.0))/(24.0*24.0) + ((y-38.0)*(y-38.0))/(13.0*13.0);
            if (b < 1) v = 255;
            // stripes: vertical black bars on body
            if (b < 1 && ((x % 8) < 3)) v = 0;
            // neck: bar up right
            if (x >= 70 && x <= 78 && y >= 18 && y <= 34) v = 255;
            // head: long bar right
            if (x >= 76 && x <= 96 && y >= 16 && y <= 26) v = 255;
            // ears: 2 small triangles
            if (x >= 74 && x <= 79 && y >= 10 && y <= 10 + (79 - x)) v = 255;
            if (x >= 80 && x <= 85 && y >= 10 && y <= 10 + (x - 80)) v = 255;
            // mane: dots
            if (sqrt(cast(double)((x-72)*(x-72) + (y-18)*(y-18))) < 2) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-26)*(y-26))) < 2) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-82)*(x-82) + (y-20)*(y-20))) < 2) v = 0;
            // nostril: black dot
            if (sqrt(cast(double)((x-92)*(x-92) + (y-22)*(y-22))) < 1.5) v = 0;
            // legs: 4 bars
            if (x >= 38 && x <= 42 && y >= 48 && y <= 60) v = 255;
            if (x >= 52 && x <= 56 && y >= 48 && y <= 60) v = 255;
            if (x >= 64 && x <= 68 && y >= 48 && y <= 60) v = 255;
            if (x >= 74 && x <= 78 && y >= 48 && y <= 60) v = 255;
            // tail: bar down left
            if (x >= 30 && x <= 34 && y >= 30 && y <= 44) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm50.ximg", header ~ comp);
    std.file.write("rm50.raw", raw);
    writefln("made rm50.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
