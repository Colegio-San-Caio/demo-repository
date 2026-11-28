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
            double b = ((x-60.0)*(x-60.0))/(28.0*28.0) + ((y-38.0)*(y-38.0))/(17.0*17.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 17) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 4) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 4) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 1.5) v = 0;
            if (x >= 44 && x <= 76 && y >= 32 && y <= 33) v = 0;
            if (x >= 48 && x <= 72 && y >= 46 && y <= 48) v = 0;
            if (x >= 40 && x <= 46 && y >= 50 && y <= 54) v = 255;
            if (x >= 74 && x <= 80 && y >= 50 && y <= 54) v = 255;
            if (x >= 30 && x <= 90 && y >= 56 && y <= 58) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm71.ximg", header ~ comp);
    std.file.write("rm71.raw", raw);
    writefln("made rm71.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
