if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
    if type rustup >/dev/null; then
        toolchain=`rustup show | grep default | awk '{print $1}'`
        export RUST_SRC_PATH="$HOME/.rustup/toolchains/$toolchain/lib/rustlib/src/rust/src"
    fi
fi
