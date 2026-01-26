# Building BadWDSD Firmware for Raspberry Pi Pico / Pico Zero

**What it builds:** `.uf2` – firmware for Raspberry Pi Pico / Pico Zero (modchip hardware).

**Versions:** [Polski](BUILD_pl.md) | **English**

---

BadWDSD modchip firmware (firmware for **Raspberry Pi Pico** or **Pico Zero**) is built from the `BadWDSD/` directory (the one containing `build-all.sh`).

## Requirements

- **CMake** ≥ 3.13  
- **GCC ARM**: `arm-none-eabi-gcc` (e.g., from `gcc-arm-none-eabi` package)  
- **Python 3** (for PIO/pico_sdk)  
- **Make**

Installation on Debian/Ubuntu:

```bash
sudo apt install cmake gcc-arm-none-eabi build-essential python3
```

## Quick build: Pico Zero only

```bash
cd BadWDSD    # directory with build-all.sh, build.sh, pico_sdk
./build-zero.sh
```

Output file: **`out/BadWDSD_SW_x32_Zero.uf2`** – flash it to Pico Zero in BOOTSEL mode (hold BOOTSEL, connect USB, drag & drop the .uf2 file).

---

## Building all versions (`build-all.sh`)

```bash
cd BadWDSD
./build-all.sh
```

Creates `out/` directory with:

| File | Description |
|------|-------------|
| `BadWDSD_SW_x32.uf2` | Regular Pico, SW mode, XDR x32 |
| `BadWDSD_SW_x32_Zero.uf2` | **Pico Zero**, SW mode, XDR x32 |
| `BadWDSD_CXRF_x16.uf2` | Regular Pico, CXRF mode, XDR x16 |

---

## Building a specific version (manual)

1. Navigate to the directory with `build.sh`:

   ```bash
   cd BadWDSD
   ```

2. Prepare `Config.h` in `BadWDSD/build/`:

   - **Pico Zero (SW, XDR x32):**
     ```bash
     mkdir -p BadWDSD/build
     echo -e '#define PICO_IS_ZERO 1\n#define SC_IS_SW 1\n#define XDR_IS_X32 1' > BadWDSD/build/Config.h
     ```
   - **Regular Pico (SW, XDR x32):**
     ```bash
     mkdir -p BadWDSD/build
     echo -e '#define SC_IS_SW 1\n#define XDR_IS_X32 1' > BadWDSD/build/Config.h
     ```
   - **Regular Pico (CXRF, XDR x16):**
     ```bash
     mkdir -p BadWDSD/build
     echo '' > BadWDSD/build/Config.h
     ```

3. Run the build:

   ```bash
   ./build.sh
   ```

4. The `.uf2` file will be created at:  
   `BadWDSD/build/BadWDSD.uf2`

---

## Definitions in `Config.h`

- **`PICO_IS_ZERO`** – Pico Zero (different pinout, WS2812 LED, UART, etc.)
- **`SC_IS_SW`** – "software" mode (57600 baud)
- **`XDR_IS_X32`** – XDR 32-bit (for 32-bit data path)

By default, `Include.h` includes `build/Config.h`; `build-all.sh` and `build-zero.sh` set this up for you.

---

## Flashing to Pico Zero

1. Enter BOOTSEL mode: hold **BOOTSEL**, connect USB.  
2. Pico should appear as a USB drive (e.g., `RPI-RP2`).  
3. Copy `BadWDSD_SW_x32_Zero.uf2` to that drive.  
4. After copying, Pico will restart with the new firmware.

---

## Notes

- **`pico_sdk`** is in the same directory as `build.sh`; `build.sh` sets `PICO_SDK_PATH=$PWD/pico_sdk` (before `cd`), so you don't need to configure it manually.  
- The `build.sh` script performs `cd BadWDSD` (subdirectory with `CMakeLists.txt` and sources), then `mkdir build`, `cd build`, `cmake ..`, `make`.  
- On first build, CMake may download/build picotool, pioasm, etc. – this is normal.  
- `build-zero.sh` is a convenient shortcut to build only the Pico Zero version.
