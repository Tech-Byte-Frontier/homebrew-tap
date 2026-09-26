class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.20.0/jevgate-0.20.0-aarch64-apple-darwin.tar.gz"
      sha256 "0561675f89727b2772c4246710c15c83445df1d549cd6eda41aec2c2670fc88e"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.20.0/jevgate-0.20.0-x86_64-apple-darwin.tar.gz"
      sha256 "2f7e9ef0bdd76f4a877e972fe1a0e4cb5670417c008fbd589032a0ea9cd1fff5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.20.0/jevgate-0.20.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c8cbf43ac63cc8c7179f8c47e933f7eecd906eb2194b5faf6dfe6b83f4ffb0bc"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.20.0/jevgate-0.20.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "49d4a37d353c2b66af93b6bafa5433d39e837e44a80ad70fdd7fe422c597fcc5"
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
