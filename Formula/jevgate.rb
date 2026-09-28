class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.30.0/jevgate-0.30.0-aarch64-apple-darwin.tar.gz"
      sha256 "f4f10832d6c5a510577e54782acc82b9ead8f4a3272c9158f92dbe73cc20b77a"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.30.0/jevgate-0.30.0-x86_64-apple-darwin.tar.gz"
      sha256 "57b412b416027c1b9ad56c378c5b201983abe50678ab04d18ea40763a6312e33"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.30.0/jevgate-0.30.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "35a2a20b042796784ed612186008c04a94e45097ff3c21929b3cb79996408796"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.30.0/jevgate-0.30.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fbbb3b667fc3b91aff98f61bd3cba02ba5f17703f71b669d680309c58c606df1"
    end
  end

  def install
    bin.install "jevgate"
    generate_completions_from_executable(bin/"jevgate", "completions")
    man1.mkpath
    (man1/"jevgate.1").write Utils.safe_popen_read(bin/"jevgate", "man")
    %w[auth check baseline rules init serve mcp hook completions man].each do |command|
      (man1/"jevgate-#{command}.1").write Utils.safe_popen_read(bin/"jevgate", "man", command)
    end
  end

  test do
    assert_match "jevgate #{version}", shell_output("#{bin}/jevgate --version")
    system bin/"jevgate", "rules"
  end
end
