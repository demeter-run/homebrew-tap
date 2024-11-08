class Dmtrctl < Formula
  desc "The dmtrctl application"
  homepage "https://github.com/demeter-run/cli"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.0/dmtrctl-aarch64-apple-darwin.tar.xz"
      sha256 "d6e3e687ba09056920db03b175663b247eb190327c69c9f975de888751b292d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.0/dmtrctl-x86_64-apple-darwin.tar.xz"
      sha256 "32e9decea4518da7f414c52bb25ce1f606b5725428cf8c439ec22738e510d83e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.0/dmtrctl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ab2e0a9696aa97c1cfbdf8e2052b6a3dc3cecabab7084033612b92718bc803e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.0/dmtrctl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e3e0031864d056a242b5d4ce8ba8efbf61c792a05c3a26d43251c78236c9dbc8"
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
