cask "aircaps" do
  version "1.3.1"
  sha256 "12ff7fe92a3a86f0f0ede7acaa3c6551ed4e3d5fcbcc62b94f7dfb76df2ae48d"

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
    AirCaps needs Input Monitoring (System Settings → Privacy & Security).
    If AirCaps isn't listed there, add it with the + button.
  EOS
end
