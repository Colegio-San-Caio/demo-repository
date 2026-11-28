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
            // horns: 2 small triangles
            if (x >= 46 && x <= 52 && y >= 10 && y <= 10 + (52 - x)) v = 255;
            if (x >= 68 && x <= 74 && y >= 10 && y <= 10 + (x - 68)) v = 255;
            // ears: 2 side bars
            if (x >= 36 && x <= 44 && y >= 24 && y <= 30) v = 255;
            if (x >= 76 && x <= 84 && y >= 24 && y <= 30) v = 255;
            // head: circle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32))) < 20) v = 255;
            // spots: 2 black dots on head
            if (sqrt(cast(double)((x-50)*(x-50) + (y-22)*(y-22))) < 4) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-24)*(y-24))) < 3) v = 0;
            // muzzle: ellipse cut out
            double mz = ((x-60.0)*(x-60.0))/(11.0*11.0) + ((y-40.0)*(y-40.0))/(7.0*7.0);
            if (mz < 1) v = 0;
            // nostrils: 2 dots back
            if (sqrt(cast(double)((x-56)*(x-56) + (y-40)*(y-40))) < 1.5) v = 255;
            if (sqrt(cast(double)((x-64)*(x-64) + (y-40)*(y-40))) < 1.5) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-52)*(x-52) + (y-28)*(y-28))) < 2) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-28)*(y-28))) < 2) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm43.ximg", header ~ comp);
    std.file.write("rm43.raw", raw);
    writefln("made rm43.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
