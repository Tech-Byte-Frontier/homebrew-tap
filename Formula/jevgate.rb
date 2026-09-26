class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.19.0/jevgate-0.19.0-aarch64-apple-darwin.tar.gz"
      sha256 "08c8a127e82ae3a39b3eea15538dc8eeb8f399c85b6b61372f0e6754663d3d75"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.19.0/jevgate-0.19.0-x86_64-apple-darwin.tar.gz"
      sha256 "f6a6fa0e6c7b965a8d4d74e395a33185ab3dac34bf8c0b52bc20a863b7854599"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.19.0/jevgate-0.19.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "825f7fccd3022356026dfa2b6708f715ecb7f2f4415f22d9314bbf6da81d06b6"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.19.0/jevgate-0.19.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3712354bce207c5efed8c0c86f014bdbfb87b4a266f334b60fe6048f8e05f5ec"
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
