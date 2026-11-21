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
            double b = ((x-60.0)*(x-60.0))/(28.0*28.0) + ((y-38.0)*(y-38.0))/(15.0*15.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-28)*(y-28))) < 17) v = 255;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-48)*(x-48) + (y-22)*(y-22))) < 2) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-22)*(y-22))) < 5) v = 255;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-22)*(y-22))) < 2) v = 0;
            if (x >= 42 && x <= 78 && y >= 32 && y <= 33) v = 0;
            if (x >= 58 && x <= 62 && y >= 14 && y <= 52) v = 0;
            if (sqrt(cast(double)((x-46)*(x-46) + (y-42)*(y-42))) < 2) v = 0;
            if (sqrt(cast(double)((x-74)*(x-74) + (y-42)*(y-42))) < 2) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-46)*(y-46))) < 2) v = 0;
            if (sqrt(cast(double)((x-34)*(x-34) + (y-30)*(y-30))) < 5) v = 255;
            if (sqrt(cast(double)((x-86)*(x-86) + (y-30)*(y-30))) < 5) v = 255;
            if (x >= 36 && x <= 44 && y >= 46 && y <= 54) v = 255;
            if (x >= 76 && x <= 84 && y >= 46 && y <= 54) v = 255;
            if (x >= 22 && x <= 98 && y >= 58 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm91.ximg", header ~ comp);
    std.file.write("rm91.raw", raw);
    writefln("made rm91.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
