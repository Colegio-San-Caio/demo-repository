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
            double b = ((x-60.0)*(x-60.0))/(32.0*32.0) + ((y-40.0)*(y-40.0))/(18.0*18.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-30)*(y-30))) < 20) v = 255;
            if (sqrt(cast(double)((x-47)*(x-47) + (y-21)*(y-21))) < 5) v = 255;
            if (sqrt(cast(double)((x-47)*(x-47) + (y-21)*(y-21))) < 2) v = 0;
            if (sqrt(cast(double)((x-73)*(x-73) + (y-21)*(y-21))) < 5) v = 255;
            if (sqrt(cast(double)((x-73)*(x-73) + (y-21)*(y-21))) < 2) v = 0;
            if (x >= 36 && x <= 84 && y >= 34 && y <= 36) v = 0;
            if (x >= 42 && x <= 78 && y >= 48 && y <= 50) v = 0;
            if (x >= 28 && x <= 38 && y >= 42 && y <= 58) v = 255;
            if (x >= 82 && x <= 92 && y >= 42 && y <= 58) v = 255;
            if (x >= 44 && x <= 48 && y >= 50 && y <= 56) v = 255;
            if (x >= 72 && x <= 76 && y >= 50 && y <= 56) v = 255;
            if (x >= 18 && x <= 102 && y >= 58 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm76.ximg", header ~ comp);
    std.file.write("rm76.raw", raw);
    writefln("made rm76.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
