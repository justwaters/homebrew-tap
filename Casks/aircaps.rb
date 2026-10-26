cask "aircaps" do
  version "1.4.0"
  sha256 "471839a7f184d1033c731b61cb8eba7d235a3f752ae1614c7b6148b99fcf928d"

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
