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
            double b = ((x-56.0)*(x-56.0))/(24.0*24.0) + ((y-38.0)*(y-38.0))/(14.0*14.0);
            if (b < 1) v = 255;
            // head: circle
            if (sqrt(cast(double)((x-76)*(x-76) + (y-22)*(y-22))) < 11) v = 255;
            // beak: flat bar right
            if (x >= 86 && x <= 96 && y >= 20 && y <= 25) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-78)*(x-78) + (y-20)*(y-20))) < 2) v = 0;
            // neck: bar connecting head to body
            if (x >= 68 && x <= 76 && y >= 24 && y <= 36) v = 255;
            // tail: triangle left
            if (x >= 28 && x <= 36 && y >= 28 && y <= 28 + (36 - x)) v = 255;
            if (x >= 28 && x <= 36 && y >= 34 && y <= 34 + (x - 28)) v = 255;
            // wing: arc cut out
            double wg = ((x-54.0)*(x-54.0))/(14.0*14.0) + ((y-38.0)*(y-38.0))/(7.0*7.0);
            if (wg < 1) v = 0;
            // legs: 2 bars
            if (x >= 48 && x <= 51 && y >= 50 && y <= 58) v = 255;
            if (x >= 62 && x <= 65 && y >= 50 && y <= 58) v = 255;
            // feet: 2 flat bars
            if (x >= 44 && x <= 54 && y >= 57 && y <= 60) v = 255;
            if (x >= 58 && x <= 68 && y >= 57 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm45.ximg", header ~ comp);
    std.file.write("rm45.raw", raw);
    writefln("made rm45.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
