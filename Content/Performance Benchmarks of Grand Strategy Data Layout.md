---
author: Thomas Holtvedt
date: 2026-11-03
image: /images/ogs-logo2.png
imageDescription: Open Grand Strategy Logo
lastModified: 2026-11-03
layout: ArticleLayout
published: true
subtitle: Measuring the difference between different data structures and the use of C++ in Godot
tags: OpenGS, gamedevelopment
---
# Province Data Benchmark
## Summary
C++ SoA (GDExtension) imports province data 5.0× faster and loops over it 109× faster than GDScript AoS (dev). GDScript SoA (Experimental) gains 1.3× and 2.6×. All three run the identical test on the same 18,148 provinces.

## AoS and SoA in short
**Array of Structures (AoS)** stores each province as one object holding all its fields. **Structure of Arrays (SoA)** stores one array per field, and a province is just an index into those arrays.

```
# AoS: one object per province
provinces = [
    { id: "PRV1", type: LAND,  x: 120, y: 40 },
    { id: "PRV2", type: OCEAN, x: 300, y: 85 },
]

# SoA: one array per field, province = index
ids   = ["PRV1", "PRV2"]
types = [LAND,   OCEAN]
xs    = [120,    300]
ys    = [40,     85]
```

In memory, AoS lies as `id type x y | id type x y | …`, while SoA lies as `type type type … | x x x … | y y y …`. A loop that only needs type and position reads just those arrays, so every byte it loads is one it uses.

## Results
**C++ SoA is up to 109× faster than GDScript AoS**
18,148 provinces · identical test for all three · median time, lower is better

![](/images/Pasted%20image%2020261103131117.png)

Every model runs the same two steps:

1. **Import:** parse `provinces.txt` into the model, then parse `provinces.json` and set owner and controller on each land province (from its entry, else `NNN`).
2. **Loop:** walk all provinces by index and, for each land province, sum the distance from its center to the map middle.

All three return the same sum (15,397,670) and the same 14,402 owned land provinces.

The loop computes the total distance from every land province's center to the map middle (2816, 1024).

The same steps in every model:

```
total = 0
for i in 0 .. province_count - 1:
    if type[i] == LAND:
        dx = center[i].x - 2816
        dy = center[i].y - 1024
        total += sqrt(dx * dx + dy * dy)
```

## Speed-ups
Moving the data to C++ gains far more than changing the layout inside GDScript.

|                          |          |          |
| ------------------------ | -------- | -------- |
| Comparison               | Import   | Loop     |
| SoA Godot vs AoS Godot   | 1.3×     | 2.6×     |
| C++ SoA vs SoA Godot     | 4.0×     | 43×      |
| **C++ SoA vs AoS Godot** | **5.0×** | **109×** |

|   |   |
|---|---|
|Other GDScript loop variants|Time per pass|
|SoA through getters by id|12.6 ms|
|SoA with packed arrays|0.69 ms|
|Empty loop (interpreter baseline)|0.24 ms|

Looking each province up by id is 17× slower than walking the arrays by index.

An earlier version of this page showed SoA importing 3.7× faster. Most of that came from dev's `province_owner` setter: dev assigned `NNN` first and then the real owner, erasing each province from a growing list. With the identical import, the layout itself gives 1.3×.

## Why C++ wins by so much
- **No interpreter.** An empty GDScript loop over 18k provinces already costs 0.24 ms. C++ does the whole loop in 0.017 ms, about 1 ns per province.
- **Type is a 1-byte enum.** `enum class ProvinceType : uint8_t` keeps the type column at 18 KB and makes the land check a one-byte compare.
- **SoA reads values in a row.** The loop touches only the type and position columns instead of following a reference to each province object.
- **Import is mostly parsing.** In GDScript every field split and conversion goes through the interpreter. C++ parses with `std::from_chars` and nlohmann::json directly into the columns.

## Test setup
- **Hardware:** AMD Ryzen 9 5900X (Linux VM on that machine)
- **GDScript:** Godot 4.7.2 headless; dev's `Province.gd` and Experimental's `ProvinceData.gd`
- **C++:** `gsg_cpp`'s `Archetype` and `Importer` headers with `Component::Type` as `enum class ProvinceType : uint8_t`, plus a history importer in the same style (owner and controller components, nlohmann::json 3.11.3); GCC 11 with `-O2`
- **Data:** 18,148 provinces, the same `provinces.txt` and `provinces.json` for all three
- **Method:** median of 15 imports and 200 loop passes, three full reruns; GDScript AoS and SoA runs interleaved
- **Caveat:** your Windows build uses MSVC, so its C++ numbers may differ slightly
