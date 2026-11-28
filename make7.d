import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;

void main() {
    int w = 120, h = 64;
    // 5x7 pixel font, 1 = white
    string[] K = ["10001","10010","10100","11000","10100","10010","10001"];
    string[] A = ["01110","10001","10001","11111","10001","10001","10001"];
    string[] I = ["11111","00100","00100","00100","00100","00100","11111"];
    string[][] letters = [K, A, I];
    int[] xs = [15, 43, 71];
    int y0 = 14, scale = 4;

    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            ubyte v = 0;
            foreach (i, letter; letters) {
                int lx = (x - xs[i]) / scale;
                int ly = (y - y0) / scale;
                if (lx >= 0 && lx < 5 && ly >= 0 && ly < 7) {
                    if (letter[ly][lx] == '1') v = 255;
                }
            }
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm7.ximg", header ~ comp);
    std.file.write("rm7.raw", raw);
    writefln("made rm7.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
