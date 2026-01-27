# Konfiguracja środowiska deweloperskiego PS3

**Co buduje:** `.pkg` – pakiet instalacyjny dla PS3 (używany do instalacji Stagex.bin i bootowania OtherOS).

**Wersje:** [English](BUILD.md) | **Polski**

---

## 1. Pobieranie i przygotowanie

Pobierz archiwum toolchain:
* **Link:** [Pobierz ps3dev_27122022.tar.gz](https://www.mediafire.com/file/i48teby46wtpbg4/ps3dev_27122022.tar.gz/file)

**Kroki:**
1.  Rozpakuj archiwum.
2.  Przenieś folder `ps3dev` obok katalogu projektu.

---

## 2. Konfiguracja

### Ustawienie zmiennych środowiskowych

Uruchom następujące polecenia w terminalu (zastąp `<your_dir>` rzeczywistą ścieżką):

```bash
export PSL1GHT=<your_dir>/ps3dev
export PATH=$PATH:<your_dir>/ps3dev/ppu/bin

```

### Utworzenie symlinku

**Ważne:** Toolchain ma zahardkodowane ścieżki szukające `/usr/local/ps3dev`. Musisz utworzyć ten symlink, żeby działał.

```bash
sudo ln -s <your_dir>/ps3dev /usr/local/ps3dev

```

---

## 3. Budowanie projektu

Gdy środowisko jest skonfigurowane, przejdź do folderu projektu i uruchom:

```bash
make pkg

```

---

## 4. Wsparcie dla Python 2.7 (jeśli potrzebne)

Jeśli Twój system nie ma Pythona 2.7 (np. Debian 13+, Ubuntu 24.04+), wykonaj następujące kroki, aby zainstalować go przez `pyenv`.

### Instalacja zależności

Najpierw zainstaluj niezbędne narzędzia build i biblioteki:

```bash
sudo apt update
sudo apt install build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev curl git libncursesw5-dev xz-utils \
tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

```

### Instalacja pyenv i Pythona 2.7.18

```bash
# Instalacja pyenv
curl https://pyenv.run | bash

# Instalacja Pythona 2.7.18
pyenv install 2.7.18

# Ustaw lokalną wersję Pythona dla bieżącego katalogu
pyenv local 2.7.18

```
