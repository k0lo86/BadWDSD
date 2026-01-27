# PS3 Development Environment Setup

**What it builds:** `.pkg` – installation package for PS3 (used to install Stagex.bin and boot OtherOS).

**Versions:** **English** | [Polski](BUILD_pl.md)

---

## 1. Download & Preparation

Download the toolchain archive:
* **Link:** [Download ps3dev_27122022.tar.gz](https://www.mediafire.com/file/i48teby46wtpbg4/ps3dev_27122022.tar.gz/file)

**Steps:**
1.  Unpack the archive.
2.  Move the `ps3dev` folder next to your project directory.

---

## 2. Configuration

### Set Environment Variables
Run the following commands in your terminal (replace `<your_dir>` with the actual path):

```bash
export PSL1GHT=<your_dir>/ps3dev
export PATH=$PATH:<your_dir>/ps3dev/ppu/bin

```

### Create Symlink

**Important:** The toolchain has hardcoded paths looking for `/usr/local/ps3dev`. You must create this symlink for it to work.

```bash
sudo ln -s <your_dir>/ps3dev /usr/local/ps3dev

```

---

## 3. Build Project

Once the environment is set up, navigate to your project folder and run:

```bash
make pkg

```

---

## 4. Python 2.7 Support (If needed)

If your system is missing Python 2.7 (e.g., Debian 13+, Ubuntu 24.04+), follow these steps to install it via `pyenv`.

### Install Dependencies

First, install the necessary build tools and libraries:

```bash
sudo apt update
sudo apt install build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev curl git libncursesw5-dev xz-utils \
tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

```

### Install pyenv and Python 2.7.18

```bash
# Install pyenv
curl [https://pyenv.run](https://pyenv.run) | bash

# Install Python 2.7.18
pyenv install 2.7.18

# Set local python version for the current directory
pyenv local 2.7.18

```
