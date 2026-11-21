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
            double b = ((x-56.0)*(x-56.0))/(24.0*24.0) + ((y-42.0)*(y-42.0))/(12.0*12.0);
            if (b < 1) v = 255;
            // spots: black dots on body
            if (sqrt(cast(double)((x-44)*(x-44) + (y-40)*(y-40))) < 3) v = 0;
            if (sqrt(cast(double)((x-58)*(x-58) + (y-44)*(y-44))) < 3) v = 0;
            if (sqrt(cast(double)((x-68)*(x-68) + (y-38)*(y-38))) < 3) v = 0;
            // long neck: tall bar up right
            if (x >= 72 && x <= 80 && y >= 12 && y <= 38) v = 255;
            // head: circle on top of neck
            if (sqrt(cast(double)((x-80)*(x-80) + (y-12)*(y-12))) < 8) v = 255;
            // ossicones: 2 small bars on head
            if (x >= 76 && x <= 78 && y >= 2 && y <= 6) v = 255;
            if (x >= 82 && x <= 84 && y >= 2 && y <= 6) v = 255;
            // ears: 2 small bars
            if (x >= 70 && x <= 75 && y >= 10 && y <= 13) v = 255;
            if (x >= 85 && x <= 90 && y >= 10 && y <= 13) v = 255;
            // eye: black dot
            if (sqrt(cast(double)((x-82)*(x-82) + (y-10)*(y-10))) < 1.5) v = 0;
            // legs: 4 tall bars
            if (x >= 38 && x <= 42 && y >= 50 && y <= 60) v = 255;
            if (x >= 52 && x <= 56 && y >= 50 && y <= 60) v = 255;
            if (x >= 64 && x <= 68 && y >= 50 && y <= 60) v = 255;
            if (x >= 74 && x <= 78 && y >= 50 && y <= 60) v = 255;
            // tail: bar down left
            if (x >= 30 && x <= 34 && y >= 34 && y <= 46) v = 255;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm51.ximg", header ~ comp);
    std.file.write("rm51.raw", raw);
    writefln("made rm51.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
