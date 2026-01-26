# Budowanie BadWDSD-Stage (Stagex.bin)

**Co buduje:** `Stagex.bin` – główny payload modchipu BadWDSD, instalowany na PS3 (NOR flash / MMIO).

**Wersje:** [English](BUILD.md) | **Polski**

---

## Najpierw musisz zainstalować poniższe pakiety:

```bash
sudo apt update
sudo apt install gcc-powerpc64-linux-gnu g++-powerpc64-linux-gnu clang libstdc++-dev g++
```

## Ustawienie zmiennych środowiskowych

Uruchom następujące polecenia w terminalu (zastąp `<your_dir>` rzeczywistą ścieżką):

```bash
export PS3DEV=<your_dir>/ps3dev
```

Po instalacji, po prostu uruchom `./build.sh`.
