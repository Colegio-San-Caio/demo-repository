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
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 14) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 50 && x <= 70 && y >= 32 && y <= 33) v = 0;
            if (sqrt(cast(double)((x-36)*(x-36) + (y-46)*(y-46))) < 2) v = 0;
            if (sqrt(cast(double)((x-36)*(x-36) + (y-46)*(y-46))) < 3) v = 255;
            if (sqrt(cast(double)((x-84)*(x-84) + (y-46)*(y-46))) < 2) v = 0;
            if (sqrt(cast(double)((x-84)*(x-84) + (y-46)*(y-46))) < 3) v = 255;
            if (sqrt(cast(double)((x-42)*(x-42) + (y-52)*(y-52))) < 2) v = 0;
            if (sqrt(cast(double)((x-42)*(x-42) + (y-52)*(y-52))) < 3) v = 255;
            if (sqrt(cast(double)((x-78)*(x-78) + (y-52)*(y-52))) < 2) v = 0;
            if (sqrt(cast(double)((x-78)*(x-78) + (y-52)*(y-52))) < 3) v = 255;
            if (x >= 38 && x <= 46 && y >= 44 && y <= 54) v = 255;
            if (x >= 74 && x <= 82 && y >= 44 && y <= 54) v = 255;
            if (x >= 28 && x <= 92 && y >= 58 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm82.ximg", header ~ comp);
    std.file.write("rm82.raw", raw);
    writefln("made rm82.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
