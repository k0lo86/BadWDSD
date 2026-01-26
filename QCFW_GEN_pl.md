# Generowanie qCFW (quasi-CFW) dla BadWDSD

**Co buduje:** `CoreOS.bin` – qCFW (quasi-CFW) dla PS3 z modchipem BadWDSD (persystentny CFW).

**Wersje:** **Polski** | [English](QCFW_GEN.md)

---

Skrypty `qcfwgen_*.sh` generują różne warianty **qCFW** (quasi-CFW) – persystentnego CFW dla PS3 z modchipem BadWDSD.

## Przegląd skryptów

Każdy skrypt generuje **inny typ** instalacji qCFW. **Nie budują tego samego** – wybierz odpowiedni wariant dla swoich potrzeb.

| Skrypt | Typ qCFW | Format lv2_kernel | Użycie |
|--------|----------|-------------------|--------|
| `qcfwgen_lv2diff.sh` | `qcfw_lv2diff` | `.diff` (patch) | Podstawowy qCFW z patchem |
| `qcfwgen_lv2self.sh` | `qcfw_lv2self` | `.self` (pełny kernel) | qCFW z pełnym kernel'em |
| `qcfwgen_lv2self_pex.sh` | `qcfw_lv2self` | `.self` + `lv2Pkernel.self` | qCFW z PEX (PEX = ?) |
| `qcfwgen_lv2zdiff.sh` | `qcfw_lv2diff` | `.zdiff` (skompresowany patch) | qCFW z kompresją |
| `qcfwgen_lv2zfself.sh` | `qcfw_lv2zfself` | `.zfself` (skompresowany fself) | qCFW z pełnym skompresowanym kernel'em |
| `qcfwgen_petitboot.sh` | `qcfw_petitboot` | Petitboot bootloader | qCFW z OtherOS bootloaderem |

---

## Wymagane pliki w `work_dir`

Wszystkie skrypty wymagają katalogu roboczego (`work_dir`) z plikami OFW (Original Firmware):

### Wspólne dla wszystkich:
- **`inros.bin`** – OFW CoreOS (wejściowy)
- **`lv1.elf.orig`** – OFW lv1 (oryginalny, niezmodyfikowany)
- **`lv1.elf`** – lv1 (OFW lub spatchowany)

### Specyficzne dla skryptu:

#### `qcfwgen_lv2diff.sh`:
- `lv2_kernel.elf.orig` (OFW)
- `lv2_kernel.elf` (OFW lub spatchowany)

#### `qcfwgen_lv2self.sh`:
- `lv2_kernel.self` (OFW lub spatchowany)
- `lv2_kernel.elf.orig` (OFW)
- `lv2_kernel.elf` (OFW lub spatchowany)

#### `qcfwgen_lv2self_pex.sh`:
- `lv2_kernel.self` (OFW lub spatchowany)
- `lv2Pkernel.self` (OFW lub spatchowany)
- `lv2_kernel.elf.orig` (OFW)
- `lv2_kernel.elf` (OFW lub spatchowany)

#### `qcfwgen_lv2zdiff.sh`:
- `lv2_kernel.elf.orig` (OFW)
- `lv2_kernel.elf` (OFW lub spatchowany)

#### `qcfwgen_lv2zfself.sh`:
- `lv2_kernel.elf` (OFW lub spatchowany)

#### `qcfwgen_petitboot.sh`:
- `dtbImage.ps3.bin` (Petitboot bootloader)

---

## Użycie

### Podstawowa składnia:

```bash
cd /home/kolo/gitlaby/ps3_test/BadWDSD
./qcfwgen_<typ>.sh <work_dir>
```

Przykład:

```bash
./qcfwgen_lv2diff.sh my_qcfw_work
```

### Kolejność uruchamiania

**Nie trzeba uruchamiać w żadnej kolejności** – każdy skrypt jest **niezależny**. Wybierz jeden skrypt odpowiadający Twojemu przypadkowi użycia.

---

## Co robi każdy skrypt

### 1. `qcfwgen_lv2diff.sh`

Generuje qCFW z **patchem** lv2_kernel (`.diff`).

**Proces:**
1. Buduje Stage payloads (Stage3j, 3ja, 3jz, 5j, 6j)
2. Buduje narzędzia (coreos_tools, lv1gen, lv2gen)
3. Ekstrahuje `inros.bin` → `inros/`
4. Instaluje Stage payloads do `lv1.elf` → `lv1.stage3j3ja3jz5j6j.elf`
5. Generuje `lv1.diff` (różnica między oryginalnym a spatchowanym lv1)
6. Generuje `lv2_kernel.diff` (różnica między oryginalnym a spatchowanym lv2_kernel)
7. Tworzy `outros/` z:
   - `lv1.diff`
   - `lv2_kernel.diff`
   - SPU loaders (`myappldr.elf`, `mylv2ldr.elf`)
8. Generuje `CoreOS.bin` z `outros/`

**Wynik:** `CoreOS.bin` z typem `qcfw_lv2diff`

---

### 2. `qcfwgen_lv2self.sh`

Generuje qCFW z **pełnym** lv2_kernel (`.self`).

**Różnice względem `lv2diff`:**
- Używa `Stage2j.bin` (dodatkowy stage)
- Buduje `zgen` (kompresor)
- Generuje `lv2_kernel.zdiff` (skompresowany diff)
- Kopiuje `lv2_kernel.self` do `outros/` (zamiast diff)
- Usuwa `hdd_copy.self` z outros (w `lv2diff` jest zakomentowane)

**Wynik:** `CoreOS.bin` z typem `qcfw_lv2self`

---

### 3. `qcfwgen_lv2self_pex.sh`

Jak `lv2self`, ale dodatkowo kopiuje **`lv2Pkernel.self`** do `outros/`.

**Różnice:**
- Kopiuje `lv2Pkernel.self` do `outros/lv2Pkernel.self`
- Usuwa `hdd_copy.self` (nie jest zakomentowane)

**PEX** prawdopodobnie oznacza jakiś specjalny tryb/wariant kernel'a.

**Wynik:** `CoreOS.bin` z typem `qcfw_lv2self` (z PEX)

---

### 4. `qcfwgen_lv2zdiff.sh`

Generuje qCFW z **skompresowanym** patchem (`.zdiff`).

**Różnice względem `lv2diff`:**
- Używa `Stage2j.bin`
- Buduje `zgen`
- Generuje `lv2_kernel.zdiff` (skompresowany diff) zamiast zwykłego `.diff`
- Kopiuje `lv2_kernel.zdiff` do `outros/` (zamiast `.diff`)

**Wynik:** `CoreOS.bin` z typem `qcfw_lv2diff` (skompresowany)

---

### 5. `qcfwgen_lv2zfself.sh`

Generuje qCFW z **skompresowanym fself** (`.zfself`).

**Proces:**
1. Buduje Stage payloads (Stage2j, 3j, 3ja, **4j**, 5j, 6j) – używa `Stage4j` zamiast `3jz`
2. Buduje narzędzia (coreos_tools, lv1gen, **zgen**, **dtbImage_ps3_bin_to_elf**)
3. Instaluje Stage do lv1 z `lv1gen_4j` (zamiast `lv1gen_3jz`)
4. Generuje `lv2_kernel.zelf` (skompresowany ELF)
5. Generuje `lv2_kernel.zzelf` (konwersja dtbImage)
6. **Wymaga ręcznego wykonania:** `make_fself -u lv2_kernel.zzelf lv2_kernel.zfself`
7. Kopiuje `lv2_kernel.zfself` jako `lv2_kernel.self` do `outros/`

**Wynik:** `CoreOS.bin` z typem `qcfw_lv2zfself`

---

### 6. `qcfwgen_petitboot.sh`

Generuje qCFW z **Petitboot bootloaderem** (OtherOS).

**Proces:**
1. Buduje Stage payloads (Stage2j, 3j, 3ja, **4j**, 5j, 6j)
2. Buduje narzędzia (coreos_tools, lv1gen, **zgen**, **dtbImage_ps3_bin_to_elf**)
3. Instaluje Stage do lv1 z `lv1gen_4j`
4. **Usuwa więcej plików** z `outros/`:
   - `hdd_copy.self`
   - `emer_init.self`
   - `eurus_fw.bin`
   - `me_iso_for_ps2emu.self`
   - `sv_iso_for_ps2emu.self`
5. Konwertuje `dtbImage.ps3.bin` → `.elf` → `.zelf` → `.zzelf`
6. **Wymaga ręcznego wykonania:** `make_fself -u dtbImage.ps3.zzelf dtbImage.ps3.zfself`
7. Kopiuje `dtbImage.ps3.zfself` jako `lv2_kernel.self` do `outros/`

**Wynik:** `CoreOS.bin` z typem `qcfw_petitboot` – konsola zawsze bootuje do Petitboot (OtherOS)

---

## Który skrypt wybrać?

| Potrzeba | Skrypt |
|----------|--------|
| Podstawowy qCFW (patch) | `qcfwgen_lv2diff.sh` |
| qCFW z pełnym kernel'em | `qcfwgen_lv2self.sh` |
| qCFW z PEX | `qcfwgen_lv2self_pex.sh` |
| qCFW z kompresją (patch) | `qcfwgen_lv2zdiff.sh` |
| qCFW z kompresją (pełny kernel) | `qcfwgen_lv2zfself.sh` |
| OtherOS / Petitboot | `qcfwgen_petitboot.sh` |

---

## Uwagi

1. **Wszystkie skrypty** budują najpierw:
   - `BadWDSD-Stage` (payloads)
   - `tools/coreos_tools`
   - `tools/lv1gen`
   - `tools/lv2gen` (jeśli potrzebne)
   - `tools/zgen` (jeśli potrzebne)

2. **Interaktywne pauzy:**
   - Większość skryptów ma `read -p "Modify outros now then press ENTER to continue"` – możesz edytować `outros/` przed finalnym buildem
   - `qcfwgen_lv2zfself.sh` i `qcfwgen_petitboot.sh` wymagają ręcznego wykonania `make_fself`

3. **Wynik:** Wszystkie generują `CoreOS.bin` w `work_dir/` – to jest plik do instalacji na PS3.

4. **SPU loaders:** Wszystkie kopiują `spu/myappldr/myappldr.elf` i `spu/mylv2ldr/mylv2ldr.elf` do `outros/`.

5. **Plik `qcfw`:** Każdy skrypt tworzy `outros/qcfw` z typem qCFW (np. `"qcfw_lv2diff"`).

---

## Przykład użycia

```bash
# Przygotuj work_dir z plikami OFW
mkdir -p my_qcfw
cd my_qcfw
# Skopiuj tu: inros.bin, lv1.elf.orig, lv1.elf, lv2_kernel.elf.orig, lv2_kernel.elf

# Wygeneruj qCFW
cd ..
./qcfwgen_lv2diff.sh my_qcfw

# Wynik: my_qcfw/CoreOS.bin
```
