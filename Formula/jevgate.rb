class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.24.0/jevgate-0.24.0-aarch64-apple-darwin.tar.gz"
      sha256 "dba9e3fc5518567fdf5e2c44fa05139acda88319d82b7eef0dc34797fd5dbf41"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.24.0/jevgate-0.24.0-x86_64-apple-darwin.tar.gz"
      sha256 "149b47120253fa8047c2a081eb2ddc51d4005af344ec48a2017335d652073125"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.24.0/jevgate-0.24.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d7e171693525adacac549f021224c8e030f821ba176dc55d49722fb2dec5d782"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.24.0/jevgate-0.24.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "18ada7def88d3d7dc8e65be75b4f38bddc15233636f7e65fb7b75e3b4be904fe"
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
