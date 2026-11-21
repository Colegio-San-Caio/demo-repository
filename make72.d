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
            double b = ((x-60.0)*(x-60.0))/(24.0*24.0) + ((y-38.0)*(y-38.0))/(14.0*14.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 15) v = 255;
            if (sqrt(cast(double)((x-51)*(x-51) + (y-23)*(y-23))) < 5) v = 255;
            if (sqrt(cast(double)((x-51)*(x-51) + (y-23)*(y-23))) < 2) v = 0;
            if (sqrt(cast(double)((x-69)*(x-69) + (y-23)*(y-23))) < 5) v = 255;
            if (sqrt(cast(double)((x-69)*(x-69) + (y-23)*(y-23))) < 2) v = 0;
            if (x >= 50 && x <= 70 && y >= 32 && y <= 33) v = 0;
            if (sqrt(cast(double)((x-52)*(x-52) + (y-38)*(y-38))) < 2) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-38)*(y-38))) < 2) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-44)*(y-44))) < 2) v = 0;
            if (x >= 36 && x <= 42 && y >= 42 && y <= 54) v = 255;
            if (x >= 78 && x <= 84 && y >= 42 && y <= 54) v = 255;
            if (x >= 28 && x <= 92 && y >= 56 && y <= 58) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm72.ximg", header ~ comp);
    std.file.write("rm72.raw", raw);
    writefln("made rm72.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
