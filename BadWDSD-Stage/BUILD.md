# Building BadWDSD-Stage (Stagex.bin)

**What it builds:** `Stagex.bin` – main BadWDSD modchip payload, installed on PS3 (NOR flash / MMIO).

**Versions:** **English** | [Polski](BUILD_pl.md)

---

## First, you need to install below packs:

```bash
sudo apt update
sudo apt install gcc-powerpc64-linux-gnu g++-powerpc64-linux-gnu clang libstdc++-dev g++
```

## Set Environment Variables
Run the following commands in your terminal (replace `<your_dir>` with the actual path):

```bash
export PS3DEV=<your_dir>/ps3dev
```

After installation, just run `./build.sh`.
