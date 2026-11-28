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
            double b = ((x-56.0)*(x-56.0))/(26.0*26.0) + ((y-38.0)*(y-38.0))/(14.0*14.0);
            if (b < 1) v = 255;
            // neck: diagonal bar up right
            if (x >= 70 && x <= 84 && y >= 14 && y <= 36) v = 255;
            // head: long bar right
            if (x >= 78 && x <= 98 && y >= 14 && y <= 24) v = 255;
            // ear: triangle on top
            if (x >= 76 && x <= 82 && y >= 8 && y <= 8 + (x - 76)) v = 255;
            // mane: dots along neck
            if (sqrt(cast(double)((x-72)*(x-72) + (y-18)*(y-18))) < 3) v = 255;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-26)*(y-26))) < 3) v = 255;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-34)*(y-34))) < 3) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-84)*(x-84) + (y-18)*(y-18))) < 2) v = 0;
            // nostril: black dot
            if (sqrt(cast(double)((x-94)*(x-94) + (y-20)*(y-20))) < 1.5) v = 0;
            // legs: 4 bars
            if (x >= 36 && x <= 40 && y >= 50 && y <= 60) v = 255;
            if (x >= 50 && x <= 54 && y >= 50 && y <= 60) v = 255;
            if (x >= 62 && x <= 66 && y >= 50 && y <= 60) v = 255;
            if (x >= 74 && x <= 78 && y >= 50 && y <= 60) v = 255;
            // tail: bar left
            if (x >= 26 && x <= 32 && y >= 26 && y <= 40) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm46.ximg", header ~ comp);
    std.file.write("rm46.raw", raw);
    writefln("made rm46.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
