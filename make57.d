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
            double b = ((x-56.0)*(x-56.0))/(24.0*24.0) + ((y-38.0)*(y-38.0))/(11.0*11.0);
            if (b < 1) v = 255;
            // head: circle right + casque triangle on top
            if (sqrt(cast(double)((x-82)*(x-82) + (y-34)*(y-34))) < 10) v = 255;
            if (x >= 76 && x <= 84 && y >= 20 && y <= 20 + (x - 76)) v = 255;
            // curled tail: spiral - circle + cut
            if (sqrt(cast(double)((x-28)*(x-28) + (y-40)*(y-40))) < 8) v = 255;
            if (sqrt(cast(double)((x-28)*(x-28) + (y-40)*(y-40))) < 4) v = 0;
            // eye: big turret circle + black dot
            if (sqrt(cast(double)((x-82)*(x-82) + (y-30)*(y-30))) < 4) v = 255;
            if (sqrt(cast(double)((x-82)*(x-82) + (y-30)*(y-30))) < 1.5) v = 0;
            // legs: 4 bars
            if (x >= 42 && x <= 47 && y >= 46 && y <= 56) v = 255;
            if (x >= 56 && x <= 61 && y >= 46 && y <= 56) v = 255;
            if (x >= 66 && x <= 71 && y >= 46 && y <= 56) v = 255;
            // spots: black dots
            if (sqrt(cast(double)((x-50)*(x-50) + (y-36)*(y-36))) < 2) v = 0;
            if (sqrt(cast(double)((x-62)*(x-62) + (y-40)*(y-40))) < 2) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm57.ximg", header ~ comp);
    std.file.write("rm57.raw", raw);
    writefln("made rm57.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
