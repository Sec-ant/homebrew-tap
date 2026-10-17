class Cinekey < Formula
  desc "Fast parser for movie and TV release names"
  homepage "https://github.com/Sec-ant/cinekey"
  version "0.4.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Sec-ant/cinekey/releases/download/v0.4.4/cinekey-0.4.4-aarch64-apple-darwin",
          using: :nounzip
      sha256 "58f3b3b3b919cd879123c6b95d51989abb991e93b12b59c8b96cc98f623cb6d5"
    end

    on_intel do
      url "https://github.com/Sec-ant/cinekey/releases/download/v0.4.4/cinekey-0.4.4-x86_64-apple-darwin",
          using: :nounzip
      sha256 "bd291a3a07e0e920bc51bd8c91fcb3b326b5c97d1b29fd9547b90d17392f96cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Sec-ant/cinekey/releases/download/v0.4.4/cinekey-0.4.4-aarch64-unknown-linux-gnu",
          using: :nounzip
      sha256 "9f81e69ae05de128ec84728bfc7b27c2ea1cbcfb87e27301f6be02982efb9e05"
    end

    on_intel do
      url "https://github.com/Sec-ant/cinekey/releases/download/v0.4.4/cinekey-0.4.4-x86_64-unknown-linux-gnu",
          using: :nounzip
      sha256 "9c54be9aa02efc308c0ddf86481beb225485e230f7ae6ef813e633118b8cd47e"
    end
  end

  def install
    bin.install File.basename(stable.url) => "cinekey"
    (bin/"cinekey").chmod 0755
  end

  test do
    output = shell_output("#{bin}/cinekey --json Young.Justice.S02.1080p.Blu-ray.DD2.0.Hi10P.x264-CtrlHD")
    media = JSON.parse(output)
    assert_equal "Young Justice", media.fetch("title")
    assert_equal 2, media.fetch("season")
    assert_equal 10, media.fetch("video_bit_depth")
    assert_equal "CtrlHD", media.fetch("release_group")
  end
end
