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
            double b = ((x-55.0)*(x-55.0))/(22.0*22.0) + ((y-34.0)*(y-34.0))/(14.0*14.0);
            if (b < 1) v = 255;
            // head: circle
            if (sqrt(cast(double)((x-75)*(x-75) + (y-24)*(y-24))) < 10) v = 255;
            // wing: ellipse cut out - black shape inside body
            double wg = ((x-52.0)*(x-52.0))/(12.0*12.0) + ((y-36.0)*(y-36.0))/(5.0*5.0);
            if (wg < 1) v = 0;
            // wing: smaller white ellipse inside cutout for detail
            double wg2 = ((x-52.0)*(x-52.0))/(8.0*8.0) + ((y-36.0)*(y-36.0))/(2.5*2.5);
            if (wg2 < 1) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-77)*(x-77) + (y-22)*(y-22))) < 2) v = 0;
            // beak: triangle
            if (x >= 84 && x <= 94 && y >= 22 + (x - 84) * 0.2 && y <= 28 - (x - 84) * 0.2) v = 255;
            // tail: triangle
            if (x >= 28 && x <= 38 && y >= 28 + (38 - x) * 0.3 && y <= 40 - (38 - x) * 0.3) v = 255;
            // legs: 2 bars
            if (x >= 48 && x <= 50 && y >= 48 && y <= 56) v = 255;
            if (x >= 60 && x <= 62 && y >= 48 && y <= 56) v = 255;
            // feet: 2 horizontal bars
            if (x >= 44 && x <= 54 && y >= 55 && y <= 57) v = 255;
            if (x >= 56 && x <= 66 && y >= 55 && y <= 57) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm32.ximg", header ~ comp);
    std.file.write("rm32.raw", raw);
    writefln("made rm32.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
