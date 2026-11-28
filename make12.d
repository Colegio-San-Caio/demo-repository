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
            // angle, with 0 = pointing up
            double a = atan2(dx, -dy);
            if (a < 0) a += 2 * PI;
            // 10 sectors: 5 outer points + 5 inner valleys
            double sectorSize = 2 * PI / 10;
            int sector = cast(int)(a / sectorSize);
            double local = (a - sector * sectorSize) / sectorSize; // 0..1
            double outerR = 30, innerR = 12;
            double maxR;
            if (sector % 2 == 0) maxR = outerR + (innerR - outerR) * local;
            else maxR = innerR + (outerR - innerR) * local;
            ubyte v = (dist < maxR) ? cast(ubyte)255 : cast(ubyte)0;
            raw ~= v;
        }
    }
    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm12.ximg", header ~ comp);
    std.file.write("rm12.raw", raw);
    writefln("made rm12.ximg %s bytes, raw %s bytes", header.length + comp.length, raw.length);
}
