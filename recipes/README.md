# 32-bit GCC Toolchain Build Order (linux-32 / Ubuntu)

This directory contains `recipe.yaml` files for re-implementing the 32-bit GNU toolchain for the `linux-32` platform using `rattler-build`, configured with an Ubuntu-based sysroot and `i686-conda_ubuntu-linux-gnu` triplets.

## Build Prerequisites
You must have `rattler-build` installed. To build for the 32-bit architecture from a 64-bit host, ensure you specify the `--target-platform linux-32` flag.

## Build Order & Commands
The toolchain must be bootstrapped in the following specific order. We use `--output-dir` to store local packages and `-c ./output` to allow subsequent steps to find them as dependencies.

### Step 1: Foundation (Sysroot)
Provides Glibc headers and libraries.
```bash
rattler-build build --recipe recipes/sysroot_linux-32/recipe.yaml \
    --target-platform linux-32 \
    --output-dir ./output
```

### Step 2: Binutils Implementation
The actual binary utilities (`ld`, `as`, `ar`).
```bash
rattler-build build --recipe recipes/binutils_impl_linux-32/recipe.yaml \
    --target-platform linux-32 \
    --output-dir ./output \
    -c ./output
```

### Step 3: Binutils Meta-package
Activation scripts for binutils.
```bash
rattler-build build --recipe recipes/binutils_linux-32/recipe.yaml \
    --target-platform linux-32 \
    --output-dir ./output \
    -c ./output
```

### Step 4: GCC Implementation
The C compiler implementation.
```bash
rattler-build build --recipe recipes/gcc_impl_linux-32/recipe.yaml \
    --target-platform linux-32 \
    --output-dir ./output \
    -c ./output
```

### Step 5: GCC Meta-package
Final activation scripts for the compiler.
```bash
rattler-build build --recipe recipes/gcc_linux-32/recipe.yaml \
    --target-platform linux-32 \
    --output-dir ./output \
    -c ./output
```

## Important Notes
*   **Source URLs**: Some URLs in the recipes (especially for `sysroot`) are placeholders and should be updated to point to your specific OS base (e.g., CentOS 6 or 7 i386 RPMs).
*   **Build Scripts**: These recipes define the metadata. You must provide the corresponding `build.sh` scripts in each directory to handle the actual GNU `configure`, `make`, and `make install` logic.
*   **Sub-packages**: A full `gcc_impl` build typically produces `libgcc-ng` and `libstdcxx-ng` as outputs. Ensure your `build.sh` and recipe outputs section handle these correctly.
