import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;

void main() {
    int w = 120, h = 64;
    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            // diagonal stripes: (x + y) makes it diagonal
            ubyte v = ((x + y) % 16 < 8) ? cast(ubyte)255 : cast(ubyte)0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm4.ximg", header ~ comp);
    std.file.write("rm4.raw", raw);
    writefln("made rm4.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
