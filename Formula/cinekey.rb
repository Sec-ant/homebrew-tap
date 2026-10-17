class Cinekey < Formula
  desc "Fast parser for movie and TV release names"
  homepage "https://github.com/Sec-ant/cinekey"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Sec-ant/cinekey/releases/download/v0.4.5/cinekey-0.4.5-aarch64-apple-darwin",
          using: :nounzip
      sha256 "b91abd2dd9f0e8d4bc749f1a4ac340287ca2781aeb14d35fbc28c6593420b27b"
    end

    on_intel do
      url "https://github.com/Sec-ant/cinekey/releases/download/v0.4.5/cinekey-0.4.5-x86_64-apple-darwin",
          using: :nounzip
      sha256 "f6db76bb5a07a3936e3391a0858cfd33cddc892347135c22a5497b5a62f3bcae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Sec-ant/cinekey/releases/download/v0.4.5/cinekey-0.4.5-aarch64-unknown-linux-gnu",
          using: :nounzip
      sha256 "152973787e2c05373afb115cd9b12e0c770691ca2aa515c429f10a29db9b0f81"
    end

    on_intel do
      url "https://github.com/Sec-ant/cinekey/releases/download/v0.4.5/cinekey-0.4.5-x86_64-unknown-linux-gnu",
          using: :nounzip
      sha256 "4baa389f52ccda5b2e26bc6f79148a6276c8c51bb7deec1a48a5ed748d1ddd35"
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
