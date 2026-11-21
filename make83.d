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
            double b = ((x-60.0)*(x-60.0))/(32.0*32.0) + ((y-40.0)*(y-40.0))/(11.0*11.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 14) v = 255;
            if (sqrt(cast(double)((x-52)*(x-52) + (y-26)*(y-26))) < 3) v = 255;
            if (sqrt(cast(double)((x-52)*(x-52) + (y-26)*(y-26))) < 1) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-26)*(y-26))) < 3) v = 255;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-26)*(y-26))) < 1) v = 0;
            if (x >= 44 && x <= 76 && y >= 34 && y <= 35) v = 0;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-40)*(y-40))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-40)*(y-40))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-40)*(y-40))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-54)*(x-54) + (y-44)*(y-44))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-66)*(x-66) + (y-44)*(y-44))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-48)*(y-48))) < 1.5) v = 0;
            if (x >= 30 && x <= 40 && y >= 42 && y <= 50) v = 255;
            if (x >= 80 && x <= 90 && y >= 42 && y <= 50) v = 255;
            if (x >= 16 && x <= 104 && y >= 56 && y <= 57) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm83.ximg", header ~ comp);
    std.file.write("rm83.raw", raw);
    writefln("made rm83.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
