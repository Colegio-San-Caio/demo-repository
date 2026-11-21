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
            // 4 ellipse wings
            double d1 = ((x-42.0)*(x-42.0))/(18.0*18.0) + ((y-22.0)*(y-22.0))/(12.0*12.0);
            double d2 = ((x-78.0)*(x-78.0))/(18.0*18.0) + ((y-22.0)*(y-22.0))/(12.0*12.0);
            double d3 = ((x-45.0)*(x-45.0))/(14.0*14.0) + ((y-42.0)*(y-42.0))/(10.0*10.0);
            double d4 = ((x-75.0)*(x-75.0))/(14.0*14.0) + ((y-42.0)*(y-42.0))/(10.0*10.0);
            if (d1 < 1) v = 255;
            if (d2 < 1) v = 255;
            if (d3 < 1) v = 255;
            if (d4 < 1) v = 255;
            // body: vertical bar
            if (x >= 58 && x <= 62 && y >= 12 && y <= 52) v = 255;
            // head
            if (sqrt(cast(double)((x-60)*(x-60) + (y-12)*(y-12))) < 4) v = 255;
            // antennae: 2 diagonal lines
            if (y >= 4 && y <= 10) {
                if (x == 60 - (10 - y)) v = 255;
                if (x == 60 + (10 - y)) v = 255;
            }
            // wing dots: black circles cut out
            if (sqrt(cast(double)((x-42)*(x-42) + (y-22)*(y-22))) < 3) v = 0;
            if (sqrt(cast(double)((x-78)*(x-78) + (y-22)*(y-22))) < 3) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm26.ximg", header ~ comp);
    std.file.write("rm26.raw", raw);
    writefln("made rm26.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
