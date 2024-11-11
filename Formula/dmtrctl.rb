class Dmtrctl < Formula
  desc "The dmtrctl application"
  homepage "https://github.com/demeter-run/cli"
  version "2.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.1/dmtrctl-aarch64-apple-darwin.tar.xz"
      sha256 "aad09fa1829c86f3743dd40806217f6752dcb95d84dbbe570ce968416594de64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.1/dmtrctl-x86_64-apple-darwin.tar.xz"
      sha256 "b5100a208004c5dcf159af1a742529a21c8650928ba1c06858b9c45ea8ccf66e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.1/dmtrctl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "be8ead06722dfcb93f6902e3cffebb892be8ac6fe8ebb48ff151f6de7bc13679"
    end
    if Hardware::CPU.intel?
      url "https://github.com/demeter-run/cli/releases/download/v2.0.1/dmtrctl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6e9b060f927827c271d22f4dab0c45fb02a58ce29a6c5d219cfcded4329f1590"
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
