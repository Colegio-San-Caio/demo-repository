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
            // body: big ellipse - fat toad
            double b = ((x-56.0)*(x-56.0))/(28.0*28.0) + ((y-38.0)*(y-38.0))/(14.0*14.0);
            if (b < 1) v = 255;
            // head: wide circle right - merged with body
            if (sqrt(cast(double)((x-80)*(x-80) + (y-34)*(y-34))) < 10) v = 255;
            // warts: black dots all over
            if (sqrt(cast(double)((x-44)*(x-44) + (y-30)*(y-30))) < 2) v = 0;
            if (sqrt(cast(double)((x-56)*(x-56) + (y-34)*(y-34))) < 2) v = 0;
            if (sqrt(cast(double)((x-66)*(x-66) + (y-40)*(y-40))) < 2) v = 0;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-44)*(y-44))) < 2) v = 0;
            // eyes: 2 big bumps on top
            if (sqrt(cast(double)((x-76)*(x-76) + (y-24)*(y-24))) < 4) v = 255;
            if (sqrt(cast(double)((x-76)*(x-76) + (y-24)*(y-24))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-86)*(x-86) + (y-24)*(y-24))) < 4) v = 255;
            if (sqrt(cast(double)((x-86)*(x-86) + (y-24)*(y-24))) < 1.5) v = 0;
            // legs: 2 front + 2 back - squat
            if (x >= 36 && x <= 44 && y >= 46 && y <= 54) v = 255;
            if (x >= 64 && x <= 72 && y >= 46 && y <= 54) v = 255;
            // mouth: bar
            if (x >= 78 && x <= 88 && y >= 38 && y <= 40) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm64.ximg", header ~ comp);
    std.file.write("rm64.raw", raw);
    writefln("made rm64.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
