class YtPdf < Formula
  include Language::Python::Virtualenv

  desc "Turn YouTube videos into styled PDF reference guides with screenshots"
  homepage "https://github.com/justwaters/yt-pdf"
  url "https://github.com/justwaters/yt-pdf/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a3e814eb9a44675bd57d6f65db80bbdf235a2b32d6df91221aec867db0a7203c"

  depends_on "ffmpeg"
  depends_on "python@3.13"

  def install
    # Isolated venv in libexec; pip resolves the dependencies declared in pyproject.toml.
    virtualenv_create(libexec, "python3.13")
    system libexec/"bin/python", "-m", "pip", "install", "--no-cache-dir", buildpath
    bin.install_symlink libexec/"bin/yt-pdf"
  end

  def post_install
    # Homebrew rewrites the install names of native libs inside the venv, which breaks the
    # signature of wheels with no header slack (nh3). macOS kills such binaries, so re-sign.
    Dir[libexec/"lib/python3.13/site-packages/**/*.{so,dylib}"].each do |lib|
      next if quiet_system "codesign", "--verify", lib

      system "codesign", "--force", "--sign", "-", lib
    end
  end

  def caveats
    <<~EOS
      yt-pdf renders PDFs with Chromium, which needs a one-time download:
        #{opt_libexec}/bin/playwright install chromium

      Then add an API key and generate a PDF:
        yt-pdf auth login
        yt-pdf "https://www.youtube.com/watch?v=VIDEO_ID"
    EOS
  end

  test do
    assert_match "yt-pdf", shell_output("#{bin}/yt-pdf --help")
    assert_match version.to_s, shell_output("#{bin}/yt-pdf --version")
  end
end
