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
            double b = ((x-60.0)*(x-60.0))/(18.0*18.0) + ((y-38.0)*(y-38.0))/(11.0*11.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 11) v = 255;
            if (sqrt(cast(double)((x-52)*(x-52) + (y-22)*(y-22))) < 4) v = 255;
            if (sqrt(cast(double)((x-52)*(x-52) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-22)*(y-22))) < 4) v = 255;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 52 && x <= 68 && y >= 31 && y <= 32) v = 0;
            if (x >= 58 && x <= 62 && y >= 18 && y <= 48) v = 0;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-40)*(y-40))) < 1) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-40)*(y-40))) < 1) v = 0;
            if (x >= 44 && x <= 48 && y >= 44 && y <= 50) v = 255;
            if (x >= 72 && x <= 76 && y >= 44 && y <= 50) v = 255;
            if (x >= 32 && x <= 88 && y >= 56 && y <= 58) v = 255;
            if (x >= 10 && x <= 14 && y >= 6 && y <= 12) v = 255;
            if (x >= 18 && x <= 22 && y >= 6 && y <= 12) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm90.ximg", header ~ comp);
    std.file.write("rm90.raw", raw);
    writefln("made rm90.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
