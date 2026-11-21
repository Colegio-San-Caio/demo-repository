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
            // body: long ellipse
            double b = ((x-56.0)*(x-56.0))/(30.0*30.0) + ((y-38.0)*(y-38.0))/(10.0*10.0);
            if (b < 1) v = 255;
            // snout: long bar right
            if (x >= 80 && x <= 104 && y >= 34 && y <= 42) v = 255;
            // jaw: small bar below snout
            if (x >= 84 && x <= 100 && y >= 44 && y <= 47) v = 255;
            // eye: black dot on top
            if (sqrt(cast(double)((x-82)*(x-82) + (y-30)*(y-30))) < 2) v = 0;
            // teeth: white dots on jaw
            if (sqrt(cast(double)((x-88)*(x-88) + (y-43)*(y-43))) < 1) v = 0;
            if (sqrt(cast(double)((x-94)*(x-94) + (y-43)*(y-43))) < 1) v = 0;
            // legs: 4 short bars
            if (x >= 38 && x <= 44 && y >= 46 && y <= 54) v = 255;
            if (x >= 52 && x <= 58 && y >= 46 && y <= 54) v = 255;
            if (x >= 64 && x <= 70 && y >= 46 && y <= 54) v = 255;
            if (x >= 74 && x <= 80 && y >= 46 && y <= 54) v = 255;
            // tail: long triangle left
            if (x >= 16 && x <= 28 && y >= 36 && y <= 36 + (28 - x)) v = 255;
            if (x >= 16 && x <= 28 && y >= 36 - (28 - x) && y <= 36) v = 255;
            // back spikes: small triangles
            if (x >= 44 && x <= 48 && y >= 26 && y <= 26 + (x - 44)) v = 255;
            if (x >= 58 && x <= 62 && y >= 26 && y <= 26 + (x - 58)) v = 255;
            if (x >= 70 && x <= 74 && y >= 28 && y <= 28 + (x - 70)) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm54.ximg", header ~ comp);
    std.file.write("rm54.raw", raw);
    writefln("made rm54.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
