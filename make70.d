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
            if (sqrt(cast(double)((x-50)*(x-50) + (y-24)*(y-24))) < 6) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-24)*(y-24))) < 2.5) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-24)*(y-24))) < 6) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-24)*(y-24))) < 2.5) v = 0;
            if (sqrt(cast(double)((x-49)*(x-49) + (y-23)*(y-23))) < 1) v = 255;
            if (sqrt(cast(double)((x-69)*(x-69) + (y-23)*(y-23))) < 1) v = 255;
            if (x >= 48 && x <= 72 && y >= 32 && y <= 33) v = 0;
            if (x >= 46 && x <= 74 && y >= 46 && y <= 48) v = 0;
            if (x >= 36 && x <= 42 && y >= 50 && y <= 56) v = 255;
            if (x >= 78 && x <= 84 && y >= 50 && y <= 56) v = 255;
            if (x >= 24 && x <= 96 && y >= 56 && y <= 58) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm70.ximg", header ~ comp);
    std.file.write("rm70.raw", raw);
    writefln("made rm70.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
