# Budowanie firmware BadWDSD dla Raspberry Pi Pico / Pico Zero

**Co buduje:** `.uf2` – firmware dla Raspberry Pi Pico / Pico Zero (modchip hardware).

**Wersje:** **Polski** | [English](BUILD.md)

---

Firmware modchipu BadWDSD (wsad do **Raspberry Pi Pico** lub **Pico Zero**) buduje się z katalogu `BadWDSD/` (tego, gdzie leży `build-all.sh`).

## Wymagania

- **CMake** ≥ 3.13  
- **GCC ARM**: `arm-none-eabi-gcc` (np. z pakietu `gcc-arm-none-eabi`)  
- **Python 3** (do PIO/pico_sdk)  
- **Make**

Instalacja na Debianie/Ubuntu:

```bash
sudo apt install cmake gcc-arm-none-eabi build-essential python3
```

## Szybkie budowanie: tylko Pico Zero

```bash
cd BadWDSD    # katalog z build-all.sh, build.sh, pico_sdk
./build-zero.sh
```

Plik wynikowy: **`out/BadWDSD_SW_x32_Zero.uf2`** – wgraj go na Pico Zero w trybie BOOTSEL (przytrzymaj BOOTSEL, podłącz USB, przeciągnij .uf2).

---

## Budowanie wszystkich wersji (`build-all.sh`)

```bash
cd BadWDSD
./build-all.sh
```

Tworzy katalog `out/` z:

| Plik | Opis |
|------|------|
| `BadWDSD_SW_x32.uf2` | Pico (zwykły), tryb SW, XDR x32 |
| `BadWDSD_SW_x32_Zero.uf2` | **Pico Zero**, tryb SW, XDR x32 |
| `BadWDSD_CXRF_x16.uf2` | Pico, tryb CXRF, XDR x16 |

---

## Budowanie wybranej wersji (ręcznie)

1. Wejdź w katalog z `build.sh`:

   ```bash
   cd BadWDSD
   ```

2. Przygotuj `Config.h` w `BadWDSD/build/`:

   - **Pico Zero (SW, XDR x32):**
     ```bash
     mkdir -p BadWDSD/build
     echo -e '#define PICO_IS_ZERO 1\n#define SC_IS_SW 1\n#define XDR_IS_X32 1' > BadWDSD/build/Config.h
     ```
   - **Pico zwykły (SW, XDR x32):**
     ```bash
     mkdir -p BadWDSD/build
     echo -e '#define SC_IS_SW 1\n#define XDR_IS_X32 1' > BadWDSD/build/Config.h
     ```
   - **Pico (CXRF, XDR x16):**
     ```bash
     mkdir -p BadWDSD/build
     echo '' > BadWDSD/build/Config.h
     ```

3. Uruchom build:

   ```bash
   ./build.sh
   ```

4. Plik `.uf2` powstaje w:  
   `BadWDSD/build/BadWDSD.uf2`

---

## Definicje w `Config.h`

- **`PICO_IS_ZERO`** – Pico Zero (inny pinout, LED WS2812, UART itd.)
- **`SC_IS_SW`** – tryb „software” (57600 Bd)
- **`XDR_IS_X32`** – XDR 32‑bit (dla 32‑bitowej ścieżki danych)

Domyślnie `Include.h` dołącza `build/Config.h`; `build-all.sh` i `build-zero.sh` ustawiają to za Ciebie.

---

## Flashowanie na Pico Zero

1. Wejdź w tryb BOOTSEL: przytrzymaj **BOOTSEL**, podłącz USB.  
2. Pico powinien się pojawić jako dysk USB (np. `RPI-RP2`).  
3. Skopiuj `BadWDSD_SW_x32_Zero.uf2` na ten dysk.  
4. Po skopiowaniu Pico się zrestartuje z nowym firmware’em.

---

## Uwagi

- **`pico_sdk`** jest w tym samym katalogu co `build.sh`; `build.sh` ustawia `PICO_SDK_PATH=$PWD/pico_sdk` (przed `cd`), więc nie trzeba go konfigurować ręcznie.  
- Skrypt `build.sh` wykonuje `cd BadWDSD` (podkatalog z `CMakeLists.txt` i źródłami), potem `mkdir build`, `cd build`, `cmake ..`, `make`.  
- Przy pierwszym buildzie CMake może ściągnąć/pobudować picotool, pioasm itd. – to normalne.  
- `build-zero.sh` jest wygodnym skrótem do zbudowania wyłącznie wersji dla Pico Zero.
