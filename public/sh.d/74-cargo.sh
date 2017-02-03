if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
    if type rustup >/dev/null; then
        toolchain=`rustup show | head -3 | tail -1 | awk '{print $1}'`
        export RUST_SRC_PATH="$HOME/.rustup/toolchains/$toolchain/lib/rustlib/src/rust/src"
    fi
fi
