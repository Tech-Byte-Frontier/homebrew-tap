class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.33.0/jevgate-0.33.0-aarch64-apple-darwin.tar.gz"
      sha256 "233bd00b9b128cc0655228dde2ab04bbb30267252ea3eee8b6f490a471736f71"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.33.0/jevgate-0.33.0-x86_64-apple-darwin.tar.gz"
      sha256 "a84e7ba5552f048de32bf9f2e4a9958a1cfe41c7ef6a569e1d0bca4bea7d5c58"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.33.0/jevgate-0.33.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "568f1d8a85ba653d7e89b9ecf1358511cd7c592745e40750ea2027e701fd61d7"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.33.0/jevgate-0.33.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c101bbe6dfbf960ac05922e314b679d0cdfdbe1f8cd2d8eea9cae4cb6be33dd5"
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
