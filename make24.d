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
            // 3 stacked circles: bottom big, middle, head small
            double d1 = sqrt(cast(double)((x-60)*(x-60) + (y-50)*(y-50)));
            double d2 = sqrt(cast(double)((x-60)*(x-60) + (y-32)*(y-32)));
            double d3 = sqrt(cast(double)((x-60)*(x-60) + (y-16)*(y-16)));
            if (d1 < 14) v = 255;
            if (d2 < 11) v = 255;
            if (d3 < 8) v = 255;
            // eyes: 2 black dots
            if (sqrt(cast(double)((x-57)*(x-57) + (y-14)*(y-14))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-63)*(x-63) + (y-14)*(y-14))) < 1.5) v = 0;
            // carrot nose: small triangle to the right
            if (y >= 16 && y <= 18 && x >= 60 && x <= 60 + (18 - y) * 2 + 6) v = 255;
            // buttons: 2 black dots on middle
            if (sqrt(cast(double)((x-60)*(x-60) + (y-30)*(y-30))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-60)*(x-60) + (y-36)*(y-36))) < 1.5) v = 0;
            // arms: diagonal lines
            if (y >= 26 && y <= 34) {
                if (x == 60 - 11 - (y - 26) * 1) v = 255;
                if (x == 60 + 11 + (y - 26) * 1) v = 255;
            }
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm24.ximg", header ~ comp);
    std.file.write("rm24.raw", raw);
    writefln("made rm24.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
