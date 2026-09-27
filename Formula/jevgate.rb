class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.22.0/jevgate-0.22.0-aarch64-apple-darwin.tar.gz"
      sha256 "a1cd5a996a27355c69ffaa24b963a8fb292cf0bad19e139c2c95208e49149b98"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.22.0/jevgate-0.22.0-x86_64-apple-darwin.tar.gz"
      sha256 "6e40005b37420d237d423fab1ea41787d56583a9332fdeee1ef9a3e2ae153d79"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.22.0/jevgate-0.22.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "944069f478a78d19ba1541a0fdab64a0b66a484f1a2627452a6106de9b3d359d"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.22.0/jevgate-0.22.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f34e0463afda5b9a046d919cbeeb84d7b1cb67ab036a1bf414d5e1978e0893f1"
    end
  end

  def install
    bin.install "jevgate"
    generate_completions_from_executable(bin/"jevgate", "completions")
    man1.mkpath
    (man1/"jevgate.1").write Utils.safe_popen_read(bin/"jevgate", "man")
    %w[auth check baseline rules init serve mcp completions man].each do |command|
      (man1/"jevgate-#{command}.1").write Utils.safe_popen_read(bin/"jevgate", "man", command)
    end
  end

  test do
    assert_match "jevgate #{version}", shell_output("#{bin}/jevgate --version")
    system bin/"jevgate", "rules"
  end
end
