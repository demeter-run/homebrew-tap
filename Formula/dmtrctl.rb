class Dmtrctl < Formula
  desc "The dmtrctl application"
  homepage "https://github.com/demeter-run/cli"
  version "1.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v1.2.0/dmtrctl-aarch64-apple-darwin.tar.xz"
      sha256 "de92f9900c20a2e62f9ba9a5fd7b2c8e398865126aca4d15c636c4a412ee0b04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v1.2.0/dmtrctl-x86_64-apple-darwin.tar.xz"
      sha256 "7444aefec907214e02d76d3597756e1bc62e51d597295dd24da9de7c9e95bc30"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v1.2.0/dmtrctl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1cac431479ffb5b4336e0cc0b28d899597f9bf06306f44d4f79025bc4c0f0a23"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v1.2.0/dmtrctl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1ce72e679ef308b376d18fdad54a73102083ea1a17094d04a8361eb5d858731b"
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
