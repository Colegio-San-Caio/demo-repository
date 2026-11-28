// XIMG Registry Editor - D Language - LDC 1.41 compatible
import std.stdio, std.file, std.zlib, std.conv, std.format, std.string;

string toHex(ubyte[] b) {
    string s = "";
    foreach(x; b) s ~= format("%02x ", x);
    return s;
}

ubyte[] loadRaw(string fn, out ubyte[] head) {
    auto d = cast(ubyte[]) std.file.read(fn);
    assert(d[0..4] == cast(ubyte[])"XIMG", "Not XIMG!");
    head = d[0..14].dup;
    auto unc = new UnCompress();
    auto raw = cast(ubyte[]) unc.uncompress(d[14..$]);
    raw ~= cast(ubyte[]) unc.flush();
    return raw;
}

void saveXimg(string fn, ubyte[] raw, int w=120) {
    ubyte[] head = new ubyte[14];
    head[0..4] = cast(ubyte[])"XIMG"; head[4]=1; head[5]=1;
    head[6]=cast(ubyte)(w & 255); head[7]=cast(ubyte)((w>>8) & 255);
    auto comp = new Compress(9);
    ubyte[] out_ = head ~ cast(ubyte[]) comp.compress(raw) ~ cast(ubyte[]) comp.flush();
    std.file.write(fn, out_);
    writefln("Saved %s: %s bytes, raw %s", fn, out_.length, raw.length);
}

void info(string fn) {
    ubyte[] head; auto raw = loadRaw(fn, head);
    int w = head[6] | (head[7]<<8);
    int h = cast(int)raw.length / w;
    writefln("=== %s ===", fn);
    writefln("Magic: %s", cast(string)head[0..4]);
    writefln("Version: %s.%s", head[4], head[5]);
    writefln("Width: %s  Height: %s", w, h);
    writefln("Header 0-13: %s", toHex(head));
    auto full = cast(ubyte[]) std.file.read(fn);
    writefln("Zlib 14-20: %s", toHex(full[14..20]));
    writefln("XIMG size: %s  RAW size: %s  Compression: %.1fx", full.length, raw.length, cast(double)raw.length/full.length);
    writefln("First 16 raw: %s", toHex(raw[0..16]));
}

void hexdump(string fn) {
    ubyte[] head; auto raw = loadRaw(fn, head);
    foreach(i; 0..raw.length) {
        if(i % 16 == 0) writef("\n%04x  ", i);
        writef("%02x ", raw[i]);
    }
    writeln();
}

void makeRm() {
    ubyte[] raw = new ubyte[7680];
    void box(int x0,int y0,int w,int h, ubyte v=255) {
        foreach(y; y0..y0+h) foreach(x; x0..x0+w)
            if(x>=0 && x<120 && y>=0 && y<64) raw[y*120+x]=v;
    }
    box(20,15,5,35); box(20,15,20,5); box(20,30,20,5); box(40,15,5,20); box(25,35,4,15); box(35,35,4,15);
    box(60,15,5,35); box(85,15,5,35); box(65,20,8,8); box(77,20,8,8); box(72,28,6,10);
    foreach(i; 0..120) raw[i] = (i%2==0) ? 0xFF : 0x14;
    foreach(i; 7680-120..7680) raw[i] = (i%2==0) ? 0xFF : 0x14;
    saveXimg("rm.ximg", raw);
    std.file.write("rm.raw", raw);
    writeln("rm.raw: 7680 bytes");
}

void main(string[] args) {
    if(args.length < 2) {
        writeln("Usage: ./ximg_tool_d <file> [info|hex]  OR  ./ximg_tool_d make-rm  OR  ./ximg_tool_d compare");
        return;
    }
    if(args[1]=="make-rm") { makeRm(); return; }
    if(args[1]=="compare") { info("kdp.ximg"); writeln(); info("rm.ximg"); return; }
    if(args[1]=="edit") {
        ubyte[] head; auto raw = loadRaw(args[2], head);
        int idx = parse!int(args[3]);
        int val = parse!int(args[4], 16);
        raw[idx] = cast(ubyte)val;
        saveXimg("kdp_edited.ximg", raw);
        writefln("Byte %s = 0x%s -> kdp_edited.ximg", args[3], args[4]);
        return;
    }
    string fn = args[1];
    string cmd = args.length>2 ? args[2] : "info";
    if(cmd=="hex") hexdump(fn); else info(fn);
}
