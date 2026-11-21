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
            double b = ((x-56.0)*(x-56.0))/(26.0*26.0) + ((y-38.0)*(y-38.0))/(14.0*14.0);
            if (b < 1) v = 255;
            // head: circle right
            if (sqrt(cast(double)((x-82)*(x-82) + (y-34)*(y-34))) < 13) v = 255;
            // snout: bar right
            if (x >= 88 && x <= 100 && y >= 36 && y <= 44) v = 255;
            // horn: triangle on top of snout
            if (x >= 92 && x <= 98 && y >= 26 && y <= 26 + (98 - x)) v = 255;
            // ear: small triangle
            if (x >= 74 && x <= 79 && y >= 20 && y <= 20 + (x - 74)) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-80)*(x-80) + (y-30)*(y-30))) < 2) v = 0;
            // nostril: black dot
            if (sqrt(cast(double)((x-96)*(x-96) + (y-40)*(y-40))) < 1.5) v = 0;
            // legs: 4 bars
            if (x >= 38 && x <= 44 && y >= 48 && y <= 60) v = 255;
            if (x >= 52 && x <= 58 && y >= 48 && y <= 60) v = 255;
            if (x >= 64 && x <= 70 && y >= 48 && y <= 60) v = 255;
            if (x >= 76 && x <= 82 && y >= 48 && y <= 60) v = 255;
            // tail: bar down left
            if (x >= 28 && x <= 32 && y >= 32 && y <= 44) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm53.ximg", header ~ comp);
    std.file.write("rm53.raw", raw);
    writefln("made rm53.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
