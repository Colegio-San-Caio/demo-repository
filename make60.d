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
            // body: big ellipse
            double b = ((x-56.0)*(x-56.0))/(28.0*28.0) + ((y-38.0)*(y-38.0))/(12.0*12.0);
            if (b < 1) v = 255;
            // head: big circle right
            if (sqrt(cast(double)((x-86)*(x-86) + (y-34)*(y-34))) < 12) v = 255;
            // snout: bar right
            if (x >= 92 && x <= 104 && y >= 34 && y <= 42) v = 255;
            // forked tongue: 2 bars
            if (x >= 104 && x <= 110 && y >= 36 && y <= 38) v = 255;
            if (x >= 104 && x <= 110 && y >= 40 && y <= 42) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-84)*(x-84) + (y-30)*(y-30))) < 2) v = 0;
            // legs: 4 thick bars
            if (x >= 38 && x <= 46 && y >= 46 && y <= 58) v = 255;
            if (x >= 54 && x <= 62 && y >= 46 && y <= 58) v = 255;
            if (x >= 68 && x <= 76 && y >= 46 && y <= 58) v = 255;
            // tail: long thick bar left
            if (x >= 12 && x <= 30 && y >= 36 && y <= 42) v = 255;
            // back scales: black dots
            if (sqrt(cast(double)((x-48)*(x-48) + (y-34)*(y-34))) < 2) v = 0;
            if (sqrt(cast(double)((x-62)*(x-62) + (y-40)*(y-40))) < 2) v = 0;
            if (sqrt(cast(double)((x-70)*(x-70) + (y-32)*(y-32))) < 2) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm60.ximg", header ~ comp);
    std.file.write("rm60.raw", raw);
    writefln("made rm60.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
