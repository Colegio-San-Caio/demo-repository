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
            // body: big ellipse
            double b = ((x-56.0)*(x-56.0))/(28.0*28.0) + ((y-38.0)*(y-38.0))/(16.0*16.0);
            if (b < 1) v = 255;
            // head: big circle right
            if (sqrt(cast(double)((x-84)*(x-84) + (y-36)*(y-36))) < 14) v = 255;
            // snout: bar right
            if (x >= 88 && x <= 100 && y >= 38 && y <= 46) v = 255;
            // ears: 2 small circles on top
            if (sqrt(cast(double)((x-76)*(x-76) + (y-24)*(y-24))) < 3) v = 255;
            if (sqrt(cast(double)((x-88)*(x-88) + (y-24)*(y-24))) < 3) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-82)*(x-82) + (y-30)*(y-30))) < 2) v = 0;
            // nostril: black dot
            if (sqrt(cast(double)((x-96)*(x-96) + (y-40)*(y-40))) < 1.5) v = 0;
            // legs: 4 short bars
            if (x >= 38 && x <= 44 && y >= 50 && y <= 60) v = 255;
            if (x >= 52 && x <= 58 && y >= 50 && y <= 60) v = 255;
            if (x >= 64 && x <= 70 && y >= 50 && y <= 60) v = 255;
            if (x >= 76 && x <= 82 && y >= 50 && y <= 60) v = 255;
            // tail: small bar left
            if (x >= 26 && x <= 30 && y >= 34 && y <= 40) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm52.ximg", header ~ comp);
    std.file.write("rm52.raw", raw);
    writefln("made rm52.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
