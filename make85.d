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
            double b = ((x-60.0)*(x-60.0))/(23.0*23.0) + ((y-38.0)*(y-38.0))/(14.0*14.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 14) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 46 && x <= 54 && y >= 21 && y <= 23) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 66 && x <= 74 && y >= 21 && y <= 23) v = 0;
            if (x >= 48 && x <= 72 && y >= 32 && y <= 33) v = 0;
            if (x >= 58 && x <= 62 && y >= 16 && y <= 52) v = 0;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-42)*(y-42))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-42)*(y-42))) < 1.5) v = 0;
            if (x >= 38 && x <= 44 && y >= 46 && y <= 54) v = 255;
            if (x >= 76 && x <= 82 && y >= 46 && y <= 54) v = 255;
            if (x >= 26 && x <= 94 && y >= 58 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm85.ximg", header ~ comp);
    std.file.write("rm85.raw", raw);
    writefln("made rm85.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
