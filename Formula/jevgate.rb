class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.25.0/jevgate-0.25.0-aarch64-apple-darwin.tar.gz"
      sha256 "2aa791d8928db758683939ea27ea3872e8d826eae55d89d6528b64d25d0e6c8e"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.25.0/jevgate-0.25.0-x86_64-apple-darwin.tar.gz"
      sha256 "a4085f0ac89b87b7a365a8867c3aca76ec264a3baab6f1dcdcee6e67def6dc40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.25.0/jevgate-0.25.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "539251dc97ee603ab2c3ef28ca73dd8aea148eed3836b7d0fa23087c7fb151ac"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.25.0/jevgate-0.25.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "57638534fa5500101bb604585b5740c9212d91659a2a61e918fe706ca0fc4256"
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
