class YtPdf < Formula
  include Language::Python::Virtualenv

  desc "Turn YouTube videos into styled PDF reference guides with screenshots"
  homepage "https://github.com/justwaters/yt-pdf"
  url "https://github.com/justwaters/yt-pdf/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "de4187e8e758a030638b5914bf3a108e71ed2ab72935038d672d10e559937a25"

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
      Add an API key, then generate a PDF:
        yt-pdf auth login
        yt-pdf "https://www.youtube.com/watch?v=VIDEO_ID"

      PDFs are printed with Google Chrome or Microsoft Edge if installed; otherwise
      the first run downloads Chromium's headless shell (about 100 MB, once).
    EOS
  end

  test do
    assert_match "yt-pdf", shell_output("#{bin}/yt-pdf --help")
    assert_match version.to_s, shell_output("#{bin}/yt-pdf --version")
  end
end
