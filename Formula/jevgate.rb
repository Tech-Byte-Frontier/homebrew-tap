class Jevgate < Formula
  desc "Code-review gate that asks TypeSafe Jev small questions about your code"
  homepage "https://github.com/Tech-Byte-Frontier/jevgate"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.17.0/jevgate-0.17.0-aarch64-apple-darwin.tar.gz"
      sha256 "33b122676e662aabfc5507c37665dadecda30d98b346033db028545057909154"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.17.0/jevgate-0.17.0-x86_64-apple-darwin.tar.gz"
      sha256 "79b375a13a3eabc2a219b592af28f247b045358e90e07280b92149468ed382ec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.17.0/jevgate-0.17.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d89994f24504918a90b8b79f17abf4c45a8894440f97923aedc8a0c3cb90bf8b"
    end
    on_intel do
      url "https://github.com/Tech-Byte-Frontier/jevgate/releases/download/v0.17.0/jevgate-0.17.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7a67df20c7fd8677a8a656a1455ba64851027db1f147b390b7eea680541cb074"
    end
  end

  def install
    bin.install "jevgate"
  end

  test do
    assert_match "jevgate #{version}", shell_output("#{bin}/jevgate --version")
    system bin/"jevgate", "rules"
  end
end
