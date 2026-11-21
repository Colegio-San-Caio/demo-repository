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
            // body: wide ellipse
            double b = ((x-60.0)*(x-60.0))/(28.0*28.0) + ((y-38.0)*(y-38.0))/(16.0*16.0);
            if (b < 1) v = 255;
            // head: circle on right
            if (sqrt(cast(double)((x-82)*(x-82) + (y-30)*(y-30))) < 14) v = 255;
            // ear: big circle cut out then back - ear flap
            if (sqrt(cast(double)((x-72)*(x-72) + (y-30)*(y-30))) < 9) v = 0;
            if (sqrt(cast(double)((x-72)*(x-72) + (y-30)*(y-30))) < 6) v = 255;
            // trunk: curved bar down from head
            if (x >= 88 && x <= 94 && y >= 34 && y <= 52) v = 255;
            if (x >= 86 && x <= 92 && y >= 50 && y <= 56) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-84)*(x-84) + (y-26)*(y-26))) < 2) v = 0;
            // tusk: white triangle cut out
            if (x >= 88 && x <= 94 && y >= 36 && y <= 36 + (x - 88)) v = 0;
            // legs: 4 bars
            if (x >= 38 && x <= 44 && y >= 50 && y <= 58) v = 255;
            if (x >= 54 && x <= 60 && y >= 52 && y <= 58) v = 255;
            if (x >= 66 && x <= 72 && y >= 52 && y <= 58) v = 255;
            // tail: small line on left
            if (x >= 30 && x <= 34 && y >= 30 && y <= 38) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm40.ximg", header ~ comp);
    std.file.write("rm40.raw", raw);
    writefln("made rm40.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
