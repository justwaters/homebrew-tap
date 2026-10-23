cask "aircaps" do
  version "1.2.0"
  sha256 "2daeffcca573d545fbd624425fe03271896642e27576f3c86cb1ab6841f8dea0"

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
