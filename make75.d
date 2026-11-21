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
            double b = ((x-60.0)*(x-60.0))/(22.0*22.0) + ((y-36.0)*(y-36.0))/(14.0*14.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-26)*(y-26))) < 14) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 50 && x <= 70 && y >= 30 && y <= 31) v = 0;
            if (x >= 40 && x <= 80 && y >= 38 && y <= 39) v = 0;
            if (x >= 30 && x <= 38 && y >= 38 && y <= 50) v = 255;
            if (x >= 82 && x <= 90 && y >= 38 && y <= 50) v = 255;
            if (sqrt(cast(double)((x-32)*(x-32) + (y-52)*(y-52))) < 3) v = 255;
            if (sqrt(cast(double)((x-88)*(x-88) + (y-52)*(y-52))) < 3) v = 255;
            if (x >= 58 && x <= 62 && y >= 8 && y <= 58) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm75.ximg", header ~ comp);
    std.file.write("rm75.raw", raw);
    writefln("made rm75.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
