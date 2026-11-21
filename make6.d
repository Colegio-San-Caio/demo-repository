import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;

void main() {
    int w = 120, h = 64;
    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            // heart math: normalized coords, center 60,32
            double nx = (x - 60) / 28.0;
            double ny = (32 - y) / 28.0;
            double a = nx*nx + ny*ny - 1.0;
            // classic heart equation
            double heart = a*a*a - nx*nx * ny*ny*ny;
            ubyte v = (heart <= 0) ? cast(ubyte)255 : cast(ubyte)0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm6.ximg", header ~ comp);
    std.file.write("rm6.raw", raw);
    writefln("made rm6.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
