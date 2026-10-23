cask "aircaps" do
  version "1.3.0"
  sha256 "1f9bbdecf9c26d818533ebb01db7f1ce326cae3a7bf384d2cf24d6c23380ecff"

  url "https://github.com/justwaters/AirCaps/releases/download/v#{version}/AirCaps.dmg"
  name "AirCaps"
  desc "Menu-bar app that turns Caps Lock into an AirPods noise control switch"
  homepage "https://github.com/justwaters/AirCaps"

  depends_on macos: :ventura

  app "AirCaps.app"

  zap trash: [
    "~/Library/Preferences/com.aircaps.AirCaps.plist",
    "~/Library/Saved Application State/com.aircaps.AirCaps.savedState",
  ]

  caveats <<~EOS
    AirCaps is ad-hoc signed (no Apple Developer ID). On first launch,
    right-click the app and choose Open, or allow it under
    System Settings → Privacy & Security.

    It needs Input Monitoring (System Settings → Privacy & Security).
    If AirCaps isn't listed there, add it with the + button.
  EOS
end
