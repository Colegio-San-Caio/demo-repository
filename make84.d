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
            double b = ((x-60.0)*(x-60.0))/(24.0*24.0) + ((y-38.0)*(y-38.0))/(15.0*15.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 15) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 1.5) v = 0;
            if (x >= 49 && x <= 51 && y >= 18 && y <= 26) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 1.5) v = 0;
            if (x >= 69 && x <= 71 && y >= 18 && y <= 26) v = 0;
            if (x >= 48 && x <= 72 && y >= 32 && y <= 33) v = 0;
            if (x >= 36 && x <= 42 && y >= 50 && y <= 54) v = 255;
            if (x >= 78 && x <= 84 && y >= 50 && y <= 54) v = 255;
            if (sqrt(cast(double)((x-39)*(x-39) + (y-56)*(y-56))) < 2) v = 255;
            if (sqrt(cast(double)((x-81)*(x-81) + (y-56)*(y-56))) < 2) v = 255;
            if (x >= 38 && x <= 46 && y >= 44 && y <= 52) v = 255;
            if (x >= 74 && x <= 82 && y >= 44 && y <= 52) v = 255;
            if (x >= 24 && x <= 96 && y >= 58 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm84.ximg", header ~ comp);
    std.file.write("rm84.raw", raw);
    writefln("made rm84.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
