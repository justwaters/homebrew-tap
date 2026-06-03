class Paudit < Formula
  desc "A TUI process audit and management tool using pgrep and pkill"
  homepage "https://github.com/justwaters/paudit"
  url "https://github.com/justwaters/paudit/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "8d010e90b61538cb106704cb1ec41668cc1abe879b2d25636c539a16d39737d8"
  license "MIT"

  # Homebrew will automatically install 'newt' (which contains whiptail) as a dependency!
  depends_on "newt"

  def install
    # Installs the script into Homebrew's execution bin
    bin.install "paudit"
  end

  def caveats
    <<~EOS
      'paudit' requires root privileges to audit and terminate all system processes.
      Please run it using:
        sudo paudit
    EOS
  end

  test do
    # A simple test to make sure the binary is in the path and executable
    system "#{bin}/paudit", "--help" # Or whatever flag doesn't trigger the loop
  end
end
