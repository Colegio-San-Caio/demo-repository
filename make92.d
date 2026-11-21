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
            double b = ((x-60.0)*(x-60.0))/(22.0*22.0) + ((y-38.0)*(y-38.0))/(13.0*13.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 13) v = 255;
            if (sqrt(cast(double)((x-51)*(x-51) + (y-22)*(y-22))) < 4) v = 255;
            if (sqrt(cast(double)((x-51)*(x-51) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-69)*(x-69) + (y-22)*(y-22))) < 4) v = 255;
            if (sqrt(cast(double)((x-69)*(x-69) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 50 && x <= 70 && y >= 32 && y <= 33) v = 0;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-40)*(y-40))) < 1.2) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-40)*(y-40))) < 1.2) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-44)*(y-44))) < 1.2) v = 0;
            if (sqrt(cast(double)((x-55)*(x-55) + (y-46)*(y-46))) < 1.2) v = 0;
            if (sqrt(cast(double)((x-65)*(x-65) + (y-46)*(y-46))) < 1.2) v = 0;
            if (sqrt(cast(double)((x-40)*(x-40) + (y-30)*(y-30))) < 3) v = 255;
            if (sqrt(cast(double)((x-80)*(x-80) + (y-30)*(y-30))) < 3) v = 255;
            if (x >= 40 && x <= 46 && y >= 44 && y <= 52) v = 255;
            if (x >= 74 && x <= 80 && y >= 44 && y <= 52) v = 255;
            if (x >= 28 && x <= 92 && y >= 58 && y <= 60) v = 255;
            if (x >= 30 && x <= 34 && y >= 56 && y <= 58) v = 255;
            if (x >= 86 && x <= 90 && y >= 56 && y <= 58) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm92.ximg", header ~ comp);
    std.file.write("rm92.raw", raw);
    writefln("made rm92.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
