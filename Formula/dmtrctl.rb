class Dmtrctl < Formula
  desc "The dmtrctl application"
  homepage "https://github.com/demeter-run/cli"
  version "2.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.2/dmtrctl-aarch64-apple-darwin.tar.xz"
      sha256 "4cf76feaaaf700cd18a08edcaa2d32298ca2504835b372b9ec1198a3c8f9e194"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.2/dmtrctl-x86_64-apple-darwin.tar.xz"
      sha256 "7d10a52d94d6dcd310b203a927f8f1334586465fb42d4514708c40f5ea9026b1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.2/dmtrctl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dbbbb3a7e26aef04c873437e025ed4c435b7b9de2872ec381d735bcde62ec9e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.2/dmtrctl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "978d8b12f981b12dabffdca6afca173aa9c09f96d96a9149048bed995df2a6e0"
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
