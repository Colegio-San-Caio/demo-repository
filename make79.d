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
            double b = ((x-60.0)*(x-60.0))/(18.0*18.0) + ((y-36.0)*(y-36.0))/(11.0*11.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 11) v = 255;
            if (sqrt(cast(double)((x-53)*(x-53) + (y-22)*(y-22))) < 3) v = 255;
            if (sqrt(cast(double)((x-53)*(x-53) + (y-22)*(y-22))) < 1) v = 0;
            if (sqrt(cast(double)((x-67)*(x-67) + (y-22)*(y-22))) < 3) v = 255;
            if (sqrt(cast(double)((x-67)*(x-67) + (y-22)*(y-22))) < 1) v = 0;
            if (x >= 54 && x <= 66 && y >= 30 && y <= 31) v = 0;
            if (x >= 40 && x <= 48 && y >= 42 && y <= 50) v = 255;
            if (x >= 72 && x <= 80 && y >= 42 && y <= 50) v = 255;
            if (sqrt(cast(double)((x-30)*(x-30) + (y-14)*(y-14))) < 2) v = 0;
            if (sqrt(cast(double)((x-30)*(x-30) + (y-14)*(y-14))) < 3) v = 255;
            if (sqrt(cast(double)((x-90)*(x-90) + (y-18)*(y-18))) < 2) v = 0;
            if (sqrt(cast(double)((x-90)*(x-90) + (y-18)*(y-18))) < 3) v = 255;
            if (sqrt(cast(double)((x-84)*(x-84) + (y-10)*(y-10))) < 1) v = 0;
            if (sqrt(cast(double)((x-84)*(x-84) + (y-10)*(y-10))) < 2) v = 255;
            if (x >= 16 && x <= 104 && y >= 8 && y <= 9) v = 255;
            if (x >= 20 && x <= 100 && y >= 56 && y <= 58) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm79.ximg", header ~ comp);
    std.file.write("rm79.raw", raw);
    writefln("made rm79.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
