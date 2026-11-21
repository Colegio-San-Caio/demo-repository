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
            double dx = x - 60;
            double dy = y - 32;
            double dist = sqrt(dx*dx + dy*dy);
            double a = atan2(dy, dx); // -PI..PI, 0 = pointing right
            ubyte v = 0;
            // body: circle, but cut out mouth wedge
            if (dist < 28 && !(dx > 0 && a > -0.5 && a < 0.5)) v = 255;
            // eye: small black dot above mouth
            double edx = x - 68, edy = y - 20;
            if (sqrt(edx*edx + edy*edy) < 3) v = 0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm15.ximg", header ~ comp);
    std.file.write("rm15.raw", raw);
    writefln("made rm15.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
