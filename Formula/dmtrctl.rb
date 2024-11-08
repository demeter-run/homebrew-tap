class Dmtrctl < Formula
  desc "The dmtrctl application"
  homepage "https://github.com/demeter-run/cli"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.0/dmtrctl-aarch64-apple-darwin.tar.xz"
      sha256 "9d386bbfe4633d7cbdac135671606e9e5aec024dd6f0638f7d25c9ff427afb4b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.0/dmtrctl-x86_64-apple-darwin.tar.xz"
      sha256 "32f650b1204b12fce16786aed5ca9ff7ae838b2e2388c53982327f1861ee7937"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.0/dmtrctl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09f3f7ec917d64c7488dcf8c0ebf3734bb8736e2cbe4d6e0bc8fe71c3c657f9a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.0/dmtrctl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a0b6b6eabccdeced1bb69d12a700d61327e1c5bd3d9fa1e0093ce73da65db78b"
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
