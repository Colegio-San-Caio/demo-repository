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
            // ring every 6 pixels, alternate black/white
            int ring = cast(int)(dist / 6);
            ubyte v = (ring % 2 == 0) ? cast(ubyte)255 : cast(ubyte)0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm10.ximg", header ~ comp);
    std.file.write("rm10.raw", raw);
    writefln("made rm10.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
