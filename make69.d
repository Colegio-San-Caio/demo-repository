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
            double b = ((x-60.0)*(x-60.0))/(26.0*26.0) + ((y-38.0)*(y-38.0))/(15.0*15.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 16) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 48 && x <= 72 && y >= 32 && y <= 33) v = 0;
            if (x >= 48 && x <= 72 && y >= 38 && y <= 48) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-43)*(y-43))) < 2) v = 255;
            if (x >= 34 && x <= 40 && y >= 44 && y <= 54) v = 255;
            if (x >= 80 && x <= 86 && y >= 44 && y <= 54) v = 255;
            if (x >= 28 && x <= 92 && y >= 54 && y <= 56) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm69.ximg", header ~ comp);
    std.file.write("rm69.raw", raw);
    writefln("made rm69.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
