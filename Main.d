import std.stdio;
import std.file;
import std.zlib;
import std.bitmanip;
import std.math;
import std.net.curl;
import std.json;
import std.string;
import std.process : environment;
import std.digest.sha;

void main() {
    string samKey = environment.get("SAM_API_KEY", "SAM-83324032-b7c5-4832-860f-7339d8ac54c6");
    string gsaKey = environment.get("GSA_API_KEY", "DEMO_KEY");

    string[string] endpoints = [
        "SAM_Entity" : "https://api.sam.gov/entity-information/v3/entities?ueiSAM=VQE1VLLCX2N4",
        "SAM_Opps"   : "https://api.sam.gov/opportunities/v2/search?limit=5&postedFrom=01/01/2026&postedTo=11/17/2026",
        "PerDiem"    : "https://api.gsa.gov/travel/perdiem/v2/rates/conus/lodging/2026"
    ];

    ubyte[] combinedPayload;
    bool samActive = false;
    string regStatus = "Unknown";
    string expDate = "Unknown";
    string cageCode = "Unknown";
    string[] naicsList;

    foreach (name, url; endpoints) {
        try {
            string finalUrl = url;
            if (name.length >= 4 && name[0..4] == "SAM_") {
                finalUrl ~= (url.indexOf('?') >= 0 ? "&" : "?") ~ "api_key=" ~ samKey;
            } else {
                finalUrl ~= (url.indexOf('?') >= 0 ? "&" : "?") ~ "api_key=" ~ gsaKey;
            }

            auto client = HTTP(finalUrl);
            client.addRequestHeader("x-api-key", name.length >= 4 && name[0..4] == "SAM_" ? samKey : gsaKey);
            client.addRequestHeader("Accept", "application/json");

            ubyte[] responseData;
            client.onReceive = (ubyte[] data) {
                responseData ~= data;
                return data.length;
            };
            client.perform();

            auto status = client.statusLine.code;
            if (status == 200) {
                combinedPayload ~= responseData;
                writefln("[200 OK]  %-11s -> %s bytes", name, responseData.length);

                if (name == "SAM_Entity") {
                    auto parsed = parseJSON(cast(string)responseData);
                    if ("entityData" in parsed && parsed["entityData"].array.length > 0) {
                        auto ent = parsed["entityData"][0];
                        auto reg = ent["entityRegistration"];
                        regStatus = reg["registrationStatus"].str;
                        expDate   = ("registrationExpirationDate" in reg) ? reg["registrationExpirationDate"].str : "N/A";
                        cageCode  = ("cageCode" in reg) ? reg["cageCode"].str : "N/A";
                        samActive = (regStatus == "Active");

                        if ("assertions" in ent && "goodsAndServices" in ent["assertions"] && "naicsList" in ent["assertions"]["goodsAndServices"]) {
                            foreach (item; ent["assertions"]["goodsAndServices"]["naicsList"].array) {
                                if ("naicsCode" in item) {
                                    naicsList ~= item["naicsCode"].str;
                                }
                            }
                        }
                        writefln("          Entity: %s | CAGE: %s | Expires: %s", regStatus, cageCode, expDate);
                    }
                }
            } else {
                writefln("[%d ERR] %-11s -> %s", status, name, cast(string)responseData);
            }
        } catch (Exception e) {
            writefln("[FAIL]    %-11s -> %s", name, e.msg);
        }
    }

    auto digest = sha256Of(combinedPayload);
    string hexDigest = toHexString(digest).idup;
    writefln("Valid payload: %s bytes | SHA-256: %s", combinedPayload.length, hexDigest);

    JSONValue manifest = JSONValue([
        "uei": JSONValue("VQE1VLLCX2N4"),
        "cage": JSONValue(cageCode),
        "status": JSONValue(regStatus),
        "expirationDate": JSONValue(expDate),
        "naics": JSONValue(naicsList),
        "payloadBytes": JSONValue(combinedPayload.length),
        "sha256": JSONValue(hexDigest)
    ]);
    std.file.write("sam_status.json", manifest.toPrettyString() ~ "\n");

    int w = 120, h = 64;
    ubyte[] raw;
    foreach (y; 0..h) {
        foreach (x; 0..w) {
            ubyte v = 0;
            double b = ((x-56.0)*(x-56.0))/(24.0*24.0) + ((y-38.0)*(y-38.0))/(9.0*9.0);
            if (b < 1) v = 255;
            if (sqrt(cast(double)((x-82)*(x-82) + (y-36)*(y-36))) < 9) v = 255;
            if (x >= 44 && x <= 68 && y >= 26 && y <= 28) v = 255;
            if (sqrt(cast(double)((x-79)*(x-79) + (y-33)*(y-33))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-87)*(x-87) + (y-33)*(y-33))) < 1.5) v = 0;
            if (x >= 42 && x <= 46 && y >= 44 && y <= 52) v = 255;
            if (x >= 54 && x <= 58 && y >= 44 && y <= 52) v = 255;
            if (x >= 66 && x <= 70 && y >= 44 && y <= 52) v = 255;
            double ty = 38 + 4 * sin((x - 14) * 0.2);
            if (x >= 14 && x <= 34 && abs(y - ty) < 3) v = 255;
            if (sqrt(cast(double)((x-50)*(x-50) + (y-38)*(y-38))) < 1.5) v = 0;
            if (sqrt(cast(double)((x-62)*(x-62) + (y-38)*(y-38))) < 1.5) v = 0;

            if (x >= 2 && x <= 5 && y >= 2 && y <= 5) {
                v = samActive ? 255 : 64;
            }
            if (y == 63 && x < 32) {
                v = digest[x];
            }
            raw ~= v;
        }
    }

    ubyte[] header = cast(ubyte[])"XIMG" ~ [cast(ubyte)1, cast(ubyte)1];
    header ~= nativeToLittleEndian(cast(int)w);
    header ~= nativeToLittleEndian(cast(int)h);
    auto comp = compress(raw);
    std.file.write("rm63.ximg", header ~ comp);
    std.file.write("rm63.raw", raw);
    writefln("Wrote rm63.ximg (%s bytes) and sam_status.json", header.length + comp.length);
}
