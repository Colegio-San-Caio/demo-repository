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
            // neck: bar up right
            if (x >= 70 && x <= 78 && y >= 18 && y <= 34) v = 255;
            // head: circle
            if (sqrt(cast(double)((x-82)*(x-82) + (y-18)*(y-18))) < 9) v = 255;
            // horns: 2 curves - small bars up
            if (x >= 78 && x <= 81 && y >= 6 && y <= 12) v = 255;
            if (x >= 84 && x <= 87 && y >= 6 && y <= 12) v = 255;
            // beard: small triangle below head
            if (x >= 80 && x <= 86 && y >= 26 && y <= 26 + (86 - x)) v = 255;
            // ear: bar left
            if (x >= 70 && x <= 76 && y >= 16 && y <= 20) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-84)*(x-84) + (y-16)*(y-16))) < 2) v = 0;
            // legs: 4 bars
            if (x >= 38 && x <= 42 && y >= 48 && y <= 60) v = 255;
            if (x >= 52 && x <= 56 && y >= 48 && y <= 60) v = 255;
            if (x >= 64 && x <= 68 && y >= 48 && y <= 60) v = 255;
            if (x >= 74 && x <= 78 && y >= 48 && y <= 60) v = 255;
            // tail: small bar up left
            if (x >= 30 && x <= 34 && y >= 24 && y <= 32) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm48.ximg", header ~ comp);
    std.file.write("rm48.raw", raw);
    writefln("made rm48.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
