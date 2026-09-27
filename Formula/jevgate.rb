class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.23.0/jevgate-0.23.0-aarch64-apple-darwin.tar.gz"
      sha256 "5ab49bbf163d43393a58ea7496a9c249bc89bcd8087becf159a0a723db8a2d43"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.23.0/jevgate-0.23.0-x86_64-apple-darwin.tar.gz"
      sha256 "80e735883538700f8b761ed356c80feed55c9d93a03a61bc4c9293c7f4f51fb3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.23.0/jevgate-0.23.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d1611954bb3e1dc3fa8e6f2e76338e0ded37bf4a775aecf982e45967a0d1c047"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.23.0/jevgate-0.23.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e82fb5d478837f469a69d96720fc08240795866f9e55e2992f95e90a29aa5b1d"
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
