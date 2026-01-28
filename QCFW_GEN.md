# Generating qCFW (quasi-CFW) for BadWDSD

**What it builds:** `CoreOS.bin` – qCFW (quasi-CFW) for PS3 with BadWDSD modchip (persistent CFW).

**Versions:** [Polski](QCFW_GEN_pl.md) | **English**

---

The `qcfwgen_*.sh` scripts generate different variants of **qCFW** (quasi-CFW) – persistent CFW for PS3 with BadWDSD modchip.

## Script Overview

Each script generates a **different type** of qCFW installation. **They do not build the same thing** – choose the appropriate variant for your needs.

| Script | qCFW Type | lv2_kernel Format | Usage |
|--------|----------|-------------------|-------|
| `qcfwgen_lv2diff.sh` | `qcfw_lv2diff` | `.diff` (patch) | Basic qCFW with patch |
| `qcfwgen_lv2self.sh` | `qcfw_lv2self` | `.self` (full kernel) | qCFW with full kernel |
| `qcfwgen_lv2self_pex.sh` | `qcfw_lv2self` | `.self` + `lv2Pkernel.self` | qCFW with PEX (PEX = ?) |
| `qcfwgen_lv2zdiff.sh` | `qcfw_lv2diff` | `.zdiff` (compressed patch) | qCFW with compression |
| `qcfwgen_lv2zfself.sh` | `qcfw_lv2zfself` | `.zfself` (compressed fself) | qCFW with full compressed kernel |
| `qcfwgen_petitboot.sh` | `qcfw_petitboot` | Petitboot bootloader | qCFW with OtherOS bootloader |

---

## Required Files in `work_dir`

All scripts require a working directory (`work_dir`) with OFW (Original Firmware) files:

### Common for all:
- **`inros.bin`** – OFW CoreOS (input)
- **`lv1.elf.orig`** – OFW lv1 (original, unmodified)
- **`lv1.elf`** – lv1 (OFW or patched)

### Script-specific:

#### `qcfwgen_lv2diff.sh`:
- `lv2_kernel.elf.orig` (OFW)
- `lv2_kernel.elf` (OFW or patched)

#### `qcfwgen_lv2self.sh`:
- `lv2_kernel.self` (OFW or patched)
- `lv2_kernel.elf.orig` (OFW)
- `lv2_kernel.elf` (OFW or patched)

#### `qcfwgen_lv2self_pex.sh`:
- `lv2_kernel.self` (OFW or patched)
- `lv2Pkernel.self` (OFW or patched)
- `lv2_kernel.elf.orig` (OFW)
- `lv2_kernel.elf` (OFW or patched)

#### `qcfwgen_lv2zdiff.sh`:
- `lv2_kernel.elf.orig` (OFW)
- `lv2_kernel.elf` (OFW or patched)

#### `qcfwgen_lv2zfself.sh`:
- `lv2_kernel.elf` (OFW or patched)

#### `qcfwgen_petitboot.sh`:
- `dtbImage.ps3.bin` (Petitboot bootloader)

---

## Usage

### Basic syntax:

```bash
cd /<your_dir>/BadWDSD
./qcfwgen_<type>.sh <work_dir>
```

Example:

```bash
./qcfwgen_lv2diff.sh my_qcfw_work
```

### Execution Order

**No specific order is required** – each script is **independent**. Choose one script that matches your use case.

---

## What Each Script Does

### 1. `qcfwgen_lv2diff.sh`

Generates qCFW with lv2_kernel **patch** (`.diff`).

**Process:**
1. Builds Stage payloads (Stage3j, 3ja, 3jz, 5j, 6j)
2. Builds tools (coreos_tools, lv1gen, lv2gen)
3. Extracts `inros.bin` → `inros/`
4. Installs Stage payloads to `lv1.elf` → `lv1.stage3j3ja3jz5j6j.elf`
5. Generates `lv1.diff` (difference between original and patched lv1)
6. Generates `lv2_kernel.diff` (difference between original and patched lv2_kernel)
7. Creates `outros/` with:
   - `lv1.diff`
   - `lv2_kernel.diff`
   - SPU loaders (`myappldr.elf`, `mylv2ldr.elf`)
8. Generates `CoreOS.bin` from `outros/`

**Output:** `CoreOS.bin` with type `qcfw_lv2diff`

---

### 2. `qcfwgen_lv2self.sh`

Generates qCFW with **full** lv2_kernel (`.self`).

**Differences from `lv2diff`:**
- Uses `Stage2j.bin` (additional stage)
- Builds `zgen` (compressor)
- Generates `lv2_kernel.zdiff` (compressed diff)
- Copies `lv2_kernel.self` to `outros/` (instead of diff)
- Removes `hdd_copy.self` from outros (commented out in `lv2diff`)

**Output:** `CoreOS.bin` with type `qcfw_lv2self`

---

### 3. `qcfwgen_lv2self_pex.sh`

Like `lv2self`, but additionally copies **`lv2Pkernel.self`** to `outros/`.

**Differences:**
- Copies `lv2Pkernel.self` to `outros/lv2Pkernel.self`
- Removes `hdd_copy.self` (not commented out)

**PEX** likely means some special mode/variant of the kernel.

**Output:** `CoreOS.bin` with type `qcfw_lv2self` (with PEX)

---

### 4. `qcfwgen_lv2zdiff.sh`

Generates qCFW with **compressed** patch (`.zdiff`).

**Differences from `lv2diff`:**
- Uses `Stage2j.bin`
- Builds `zgen`
- Generates `lv2_kernel.zdiff` (compressed diff) instead of plain `.diff`
- Copies `lv2_kernel.zdiff` to `outros/` (instead of `.diff`)

**Output:** `CoreOS.bin` with type `qcfw_lv2diff` (compressed)

---

### 5. `qcfwgen_lv2zfself.sh`

Generates qCFW with **compressed fself** (`.zfself`).

**Process:**
1. Builds Stage payloads (Stage2j, 3j, 3ja, **4j**, 5j, 6j) – uses `Stage4j` instead of `3jz`
2. Builds tools (coreos_tools, lv1gen, **zgen**, **dtbImage_ps3_bin_to_elf**)
3. Installs Stage to lv1 with `lv1gen_4j` (instead of `lv1gen_3jz`)
4. Generates `lv2_kernel.zelf` (compressed ELF)
5. Generates `lv2_kernel.zzelf` (dtbImage conversion)
6. **Requires manual execution:** `make_fself -u lv2_kernel.zzelf lv2_kernel.zfself`
7. Copies `lv2_kernel.zfself` as `lv2_kernel.self` to `outros/`

**Output:** `CoreOS.bin` with type `qcfw_lv2zfself`

---

### 6. `qcfwgen_petitboot.sh`

Generates qCFW with **Petitboot bootloader** (OtherOS).

**Process:**
1. Builds Stage payloads (Stage2j, 3j, 3ja, **4j**, 5j, 6j)
2. Builds tools (coreos_tools, lv1gen, **zgen**, **dtbImage_ps3_bin_to_elf**)
3. Installs Stage to lv1 with `lv1gen_4j`
4. **Removes more files** from `outros/`:
   - `hdd_copy.self`
   - `emer_init.self`
   - `eurus_fw.bin`
   - `me_iso_for_ps2emu.self`
   - `sv_iso_for_ps2emu.self`
5. Converts `dtbImage.ps3.bin` → `.elf` → `.zelf` → `.zzelf`
6. **Requires manual execution:** `make_fself -u dtbImage.ps3.zzelf dtbImage.ps3.zfself`
7. Copies `dtbImage.ps3.zfself` as `lv2_kernel.self` to `outros/`

**Output:** `CoreOS.bin` with type `qcfw_petitboot` – console always boots to Petitboot (OtherOS)

---

## Which Script to Choose?

| Need | Script |
|------|--------|
| Basic qCFW (patch) | `qcfwgen_lv2diff.sh` |
| qCFW with full kernel | `qcfwgen_lv2self.sh` |
| qCFW with PEX | `qcfwgen_lv2self_pex.sh` |
| qCFW with compression (patch) | `qcfwgen_lv2zdiff.sh` |
| qCFW with compression (full kernel) | `qcfwgen_lv2zfself.sh` |
| OtherOS / Petitboot | `qcfwgen_petitboot.sh` |

---

## Notes

1. **All scripts** first build:
   - `BadWDSD-Stage` (payloads)
   - `tools/coreos_tools`
   - `tools/lv1gen`
   - `tools/lv2gen` (if needed)
   - `tools/zgen` (if needed)

2. **Interactive pauses:**
   - Most scripts have `read -p "Modify outros now then press ENTER to continue"` – you can edit `outros/` before final build
   - `qcfwgen_lv2zfself.sh` and `qcfwgen_petitboot.sh` require manual execution of `make_fself`

3. **Output:** All generate `CoreOS.bin` in `work_dir/` – this is the file to install on PS3.

4. **SPU loaders:** All copy `spu/myappldr/myappldr.elf` and `spu/mylv2ldr/mylv2ldr.elf` to `outros/`.

5. **`qcfw` file:** Each script creates `outros/qcfw` with qCFW type (e.g., `"qcfw_lv2diff"`).

---

## Usage Example

```bash
# Prepare work_dir with OFW files
mkdir -p my_qcfw
cd my_qcfw
# Copy here: inros.bin, lv1.elf.orig, lv1.elf, lv2_kernel.elf.orig, lv2_kernel.elf

# Generate qCFW
cd ..
./qcfwgen_lv2diff.sh my_qcfw

# Output: my_qcfw/CoreOS.bin
```
