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
            // body: ellipse
            double b = ((x-60.0)*(x-60.0))/(20.0*20.0) + ((y-36.0)*(y-36.0))/(22.0*22.0);
            if (b < 1) v = 255;
            // ear tufts: 2 triangles
            if (x >= 42 && x <= 50 && y >= 10 && y <= 10 + (x - 42)) v = 255;
            if (x >= 70 && x <= 78 && y >= 10 && y <= 10 + (78 - x)) v = 255;
            // eyes: 2 big white circles cut out
            if (sqrt(cast(double)((x-52)*(x-52) + (y-26)*(y-26))) < 7) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-26)*(y-26))) < 7) v = 0;
            // pupils: black dots back
            if (sqrt(cast(double)((x-52)*(x-52) + (y-26)*(y-26))) < 2.5) v = 255;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-26)*(y-26))) < 2.5) v = 255;
            // beak: small triangle
            if (x >= 58 && x <= 62 && y >= 32 && y <= 32 + (2 - abs(x - 60)) * 2) v = 0;
            // belly: stripes cut out - 3 arcs
            if (y == 42 && x >= 46 && x <= 74) v = 0;
            if (y == 46 && x >= 47 && x <= 73) v = 0;
            if (y == 50 && x >= 48 && x <= 72) v = 0;
            // feet: 2 bars
            if (x >= 50 && x <= 56 && y >= 57 && y <= 60) v = 255;
            if (x >= 64 && x <= 70 && y >= 57 && y <= 60) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm37.ximg", header ~ comp);
    std.file.write("rm37.raw", raw);
    writefln("made rm37.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
