import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;

void main() {
    int w = 120, h = 64;
    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            // gradient: 0 on left -> 255 on right
            ubyte v = cast(ubyte)(x * 255 / (w - 1));
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm2.ximg", header ~ comp);
    std.file.write("rm2.raw", raw);
    writefln("made rm2.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
