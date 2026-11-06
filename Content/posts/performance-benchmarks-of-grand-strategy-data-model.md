---
author: Thomas Holtvedt
date: 2026-11-06T10:29:30+01:00
tags: OpenGS, gamedevelopment
image: /images/posts/performance-benchmarks-of-grand-strategy-data-model/ogs-logo2.png
---

# Province Data Benchmark

## Introduction
A grand strategy game looks lightweight on the surface but behind the scenes there is a lot going on. there are often tens- or Hundreds of thousand rows of data being crunched simultaneously.

It is paramount that the game can do this without lagging and ruining the player experience, and the data model is what makes or breaks the performance of a game.

In this benchmark I will test out two different data models:
1) The classic object oriented way of storing data, also known as "Array of Structs(AoS)".
2) The data oriented way known as "Struct of Arrays(SoA)"
3) Finally I will benchmark using C++ to capture the overhead of the Godot Game Engine.

The tests will measure both the data import speed and the speed of a simple operation.

## Summary
C++ SoA imports province data 5.0× faster and loops over it 109× faster than GDScript AoS. 
GDScript SoA gains 1.3× and 2.6×.
All three run the identical test on the same 18,148 provinces.

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

![Pasted image 20261103131117](/images/posts/performance-benchmarks-of-grand-strategy-data-model/pasted-image-20261103131117.png)


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

## Why C++ wins by so much
- **No interpreter.** An empty GDScript loop over 18k provinces already costs 0.24 ms. C++ does the whole loop in 0.017 ms, about 1 ns per province.
- **Type is a 1-byte enum.** `enum class ProvinceType : uint8_t` keeps the type column at 18 KB and makes the land check a one-byte compare.
- **SoA reads values in a row.** The loop touches only the type and position columns instead of following a reference to each province object.
- **Import is mostly parsing.** In GDScript every field split and conversion goes through the interpreter. C++ parses with `std::from_chars` and nlohmann::json directly into the columns.

## Test setup
- **Hardware:** AMD Ryzen 9 5900X
- **Data:** 18,148 provinces, the same `provinces.txt` and `provinces.json` for all three
- **Method:** median of 15 imports and 200 loop passes, three full reruns; GDScript AoS and SoA runs interleaved
