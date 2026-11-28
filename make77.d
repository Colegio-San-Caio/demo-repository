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
            double b = ((x-60.0)*(x-60.0))/(20.0*20.0) + ((y-36.0)*(y-36.0))/(13.0*13.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-26)*(y-26))) < 13) v = 255;
            if (sqrt(cast(double)((x-51)*(x-51) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-51)*(x-51) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-69)*(x-69) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-69)*(x-69) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 52 && x <= 68 && y >= 30 && y <= 31) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-40)*(y-40))) < 2) v = 0;
            if (x >= 50 && x <= 70 && y >= 44 && y <= 46) v = 0;
            if (x >= 38 && x <= 44 && y >= 40 && y <= 52) v = 255;
            if (x >= 76 && x <= 82 && y >= 40 && y <= 52) v = 255;
            if (x >= 26 && x <= 94 && y >= 56 && y <= 58) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm77.ximg", header ~ comp);
    std.file.write("rm77.raw", raw);
    writefln("made rm77.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
