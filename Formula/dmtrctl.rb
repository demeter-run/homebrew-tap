class Dmtrctl < Formula
  desc "The dmtrctl application"
  homepage "https://github.com/demeter-run/cli"
  version "1.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v1.4.0/dmtrctl-aarch64-apple-darwin.tar.xz"
      sha256 "5f4ec83f22f4adbdb441d3430d41bcb71329fc76f3c3264984de01c98f6cfa4e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v1.4.0/dmtrctl-x86_64-apple-darwin.tar.xz"
      sha256 "1c5779933b55065e0052db1cb903a385e23e903296b874b3a413bdbbc815bf64"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v1.4.0/dmtrctl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "329205b8ef61b4bbc4b5fa8379549b97050c39f87053f6fa6b1189f92fb89817"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v1.4.0/dmtrctl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a15261a2cb56b01dd87203894d5e13f3a67f646f1422990f099e50b33f1829be"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "aarch64-unknown-linux-gnu": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dmtrctl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dmtrctl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dmtrctl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dmtrctl"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
