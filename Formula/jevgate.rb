class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.18.0/jevgate-0.18.0-aarch64-apple-darwin.tar.gz"
      sha256 "697a400938094ddc7e11aa5ec55ced398cf9b45e6011e120053ca059286383b5"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.18.0/jevgate-0.18.0-x86_64-apple-darwin.tar.gz"
      sha256 "c59d86bd3c5a6d024d4290d78ec452c326756e61f3c4f0986d452b73340935ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.18.0/jevgate-0.18.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c75f6c309238cb7e86e065300c9a39a8f6ca72bd8e2e17a1398fc63ff4bdc999"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.18.0/jevgate-0.18.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b6e425af79d15b5b959c52449eeb774f0323552186a302f1c56b1a069f4f175e"
    end
  end

  def install
    bin.install "jevgate"
    generate_completions_from_executable(bin/"jevgate", "completions")
    man1.mkpath
    (man1/"jevgate.1").write Utils.safe_popen_read(bin/"jevgate", "man")
    %w[auth check baseline rules init serve completions man].each do |command|
      (man1/"jevgate-#{command}.1").write Utils.safe_popen_read(bin/"jevgate", "man", command)
    end
  end

  test do
    assert_match "jevgate #{version}", shell_output("#{bin}/jevgate --version")
    system bin/"jevgate", "rules"
  end
end
