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
            double b = ((x-60.0)*(x-60.0))/(25.0*25.0) + ((y-38.0)*(y-38.0))/(15.0*15.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 15) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 46 && x <= 74 && y >= 32 && y <= 33) v = 0;
            if (x >= 58 && x <= 62 && y >= 15 && y <= 50) v = 0;
            if (sqrt(cast(double)((x-47)*(x-47) + (y-41)*(y-41))) < 1.3) v = 0;
            if (sqrt(cast(double)((x-73)*(x-73) + (y-41)*(y-41))) < 1.3) v = 0;
            if (sqrt(cast(double)((x-54)*(x-54) + (y-45)*(y-45))) < 1.3) v = 0;
            if (sqrt(cast(double)((x-66)*(x-66) + (y-45)*(y-45))) < 1.3) v = 0;
            if (sqrt(cast(double)((x-37)*(x-37) + (y-30)*(y-30))) < 4) v = 255;
            if (sqrt(cast(double)((x-83)*(x-83) + (y-30)*(y-30))) < 4) v = 255;
            if (x >= 37 && x <= 44 && y >= 45 && y <= 54) v = 255;
            if (x >= 76 && x <= 83 && y >= 45 && y <= 54) v = 255;
            if (x >= 25 && x <= 95 && y >= 58 && y <= 60) v = 255;
            if (x >= 30 && x <= 90 && y >= 56 && y <= 57) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm93.ximg", header ~ comp);
    std.file.write("rm93.raw", raw);
    writefln("made rm93.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
