class Dmtrctl < Formula
  desc "The dmtrctl application"
  homepage "https://github.com/demeter-run/cli"
  version "1.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v1.3.0/dmtrctl-aarch64-apple-darwin.tar.xz"
      sha256 "f1e8c2a23be504959db29217adbf42a59c36ed93ad6730cf12b88a9e1073fc2b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v1.3.0/dmtrctl-x86_64-apple-darwin.tar.xz"
      sha256 "6403179fec57a4dcf51180c8a13edca20c9600c8d8b4cf9e8175cb6a2df0ad7a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v1.3.0/dmtrctl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f2c29b3653f7e9a1b13a062633c83f1f90ef2d6318e6d06b771dde3940056084"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v1.3.0/dmtrctl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dadc1e786b7c6ca2b1add96858837ae4e0d21073dc61b37c4acbb77af71a61d2"
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
