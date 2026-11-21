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
            double b = ((x-56.0)*(x-56.0))/(25.0*25.0) + ((y-38.0)*(y-38.0))/(11.0*11.0);
            if (b < 1) v = 255;
            // head: circle right
            if (sqrt(cast(double)((x-84)*(x-84) + (y-34)*(y-34))) < 10) v = 255;
            // dewlap: triangle under head
            if (x >= 80 && x <= 88 && y >= 42 && y <= 42 + (88 - x)) v = 255;
            // dorsal spikes: small triangles on back
            if (x >= 42 && x <= 46 && y >= 24 && y <= 24 + (x - 42)) v = 255;
            if (x >= 54 && x <= 58 && y >= 24 && y <= 24 + (x - 54)) v = 255;
            if (x >= 66 && x <= 70 && y >= 26 && y <= 26 + (x - 66)) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-84)*(x-84) + (y-30)*(y-30))) < 2) v = 0;
            // legs: 4 bars
            if (x >= 40 && x <= 46 && y >= 46 && y <= 56) v = 255;
            if (x >= 54 && x <= 60 && y >= 46 && y <= 56) v = 255;
            if (x >= 66 && x <= 72 && y >= 46 && y <= 56) v = 255;
            // tail: long bar left + taper
            if (x >= 14 && x <= 32 && y >= 36 && y <= 40) v = 255;
            // stripes on tail: black dots
            if (sqrt(cast(double)((x-20)*(x-20) + (y-38)*(y-38))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-28)*(x-28) + (y-38)*(y-38))) < 1.5) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm59.ximg", header ~ comp);
    std.file.write("rm59.raw", raw);
    writefln("made rm59.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
