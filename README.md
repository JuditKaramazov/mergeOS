# mergeOS

<p align="center">
  <a href="https://github.com/JuditKaramazov/mergeOS/releases/tag/v1.0.0">
    <img src="/Screenshots/mergeOS-01.png" width="200" height="200" style="filter: drop-shadow(0px 0px 10px rgba(0, 0, 0, .7));" alt="mergeOS original logo.">
  </a>
</p>

<h1 align="center">
  mergeOS, v.1.0
</h1>

<div align="center">
  <img src="https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white" alt="Xcode" title="Xcode" />
  <img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" alt="GitHub" title="GitHub" />
  <img src="https://img.shields.io/badge/swift-%23FA7343.svg?style=for-the-badge&logo=swift&logoColor=white" alt="Swift" title="Swift" />
</div>

<br />

<p align="center">
  <a href="https:/github.com/JuditKaramazov">🐱 /JuditKaramazov</a>
</p>
<p align="center">
  <a href="https://karamazfolio.xyz/">📍 Personal site</a>
</p>
<p align="center">
  <a href="https://github.com/JuditKaramazov/mergeOS/releases/download/v1.0.0/mergeOS.zip">⬇️ App</a>
</p>

---

Table of Contents
-----------------

* [🔧 Getting started](#-getting-started)
* [🚪 Introduction](#-introduction)
* [🔮 Features](#-features)
  * [🍭 Easy to use](#-easy-to-use)
  * [⏰ Automatized](#-automatized)
  * [🐱 GitHub oriented](#-github-oriented)
  * [🎨 Customizable display](#-customizable-display)
  * [⌨️ Key bindings](#-key-bindings)
* [💅 Style](#-style)
* [🙌 Immense thanks to our awesome Sponsors](#-immense-thanks-to-our-awesome-sponsors)
* [🏛 License & Copyright](#-license--copyright)

---

## 🔧 Getting started

Much to everyone's disappointment, this is a macOS extension developed with [Swift](https://developer.apple.com/swift/) and [Xcode](https://developer.apple.com/xcode/). Considering that, make sure to have Apple's integrated development environment for macOS installed on your Mac. While Xcode is the primary IDE for Apple platform development, you can use other text editors and IDEs, such as Visual Studio Code, JetBrains AppCode - even Vim or Emacs with the Swift compiler to write and develop Swift code. However, Xcode provides a development environment with graphical tools for building macOS apps making everything significantly smoother; it's _glitchy_ as hell - but definitely worth your time!

If you simply want to give **mergeOS** a try, it is possible to install it directly without brain-draining steps obstructing the overall process:

1. Download and unzip the [latest release](https://github.com/JuditKaramazov/mergeOS/releases/tag/v1.0.0).
2. Open the app and access your account. In order to do so, you'll need to [generate a GitHub access token](https://github.com/settings/tokens/new?scopes=repo) with **repo scope**.
3. Believe it or not... you are now good to go!

Of course, I understand that some of you prefer the exciting world of exploration, little tweaks, and **development process**. If that's your case: 

1. First, clone the repo by running the following command:

```bash
$ git clone https://github.com/JuditKaramazov/mergeOS.git
```

2. Then, prepare the build:

```fish
cd mergeOS
open mergeOS.xcworkspace
```

Ready to go! If you want to test mergeOS and play with your personal derivations of it, remember that you'll need to set up a **development provisioning profile and code-signing identity** in Xcode. Refer to Apple's documentation for details on this process - and feel free to modify and customize the project as needed or desired!

---

## 🚪 Introduction

More than a simple part of the process, burnout has become an inevitable sickness. Although we all knew about this invisible yet loud reality gaining presence and weight in everyone's lives, perhaps we still hoped it would dodge us, find another host, and attack their will, vulnerabilities, and patience instead of ours. An egoistic thought, indeed - as terrible as human nature inherently _is_.

For a reason I can't truly explain, and closely related to this "burnout stain" becoming more and more noticeable, I found myself thinking _again_ of [Grant Kuning](https://twitter.com/sethiangame), the creator of an experimental, esoteric, and genuinely fascinating video game called [Sethian](https://store.steampowered.com/app/432370/Sethian). As he explained in [one of his Kickstarter updates](https://www.kickstarter.com/projects/1158657297/sethian-a-sci-fi-language-puzzle-game/posts/1731256):

> I committed to this project before I started testing. I committed to this project before I understood what I was capable of. I committed to this project before I understood how to make this game. And as a result, I made promises I couldn't keep, and a game which I have... very mixed feelings towards. (...) The loss of morale isn't some vague, nebulous concept though. To me, it seems that it comes from conditioning yourself to believe that you won't be able to solve the problem. It comes from repeatedly running up against a wall and not knowing what to do, from errors that don't make sense, from complications that you can't trace to their origins, from Google searches that turn up nothing because you don't even know what your problem is called. Eventually, you stop believing that you can do it, so you stop believing you can do other things, too.

Although he described his feelings as something not many would relate to, working in the development sector constantly feels like this "unwanted child" Kuning wanted to "put up for adoption" no matter the apparent good results and vital lessons he got from it. Recently, too, we got to know about **Microsoft's decision to close four Bethesda studios**: Tango Gameworks ([The Evil Within](https://store.steampowered.com/app/268050/The_Evil_Within/) or the recent[Hi-Fi Rush](https://store.steampowered.com/app/1817230/HiFi_RUSH/)), Arkane Austin ([Prey](https://store.steampowered.com/app/480490/Prey/), [Redfall](https://store.steampowered.com/app/1294810/Redfall/)), Alpha Dog ([Mighty Doom](https://bethesda.net/en-US/game/mightydoom)), and Roundhouse Games. Luckily for me, I had the opportunity to _vent a little bit_ by [publishing a short article on Medium](https://medium.com/@JuditKaramazov/the-gaming-industry-is-sick-and-we-dont-know-the-cure-4b4030b393b1) discussing the matter; however, these recent events and their many connotations didn't leave my thoughts for a single moment.

While we had to accept this "success narrative" as the only way to preserve our stability, these announcements only highlighted what started to be more evident than we'd want to admit: **there is no valid narrative of "success" anymore**. It's a facade. As developers (and it pains me to admit it), we do not aim at succeeding or achieving the best quality anymore. The race to run is _not_ against ourselves: everything has been reduced to an exhausting race against time, impossible deadlines, and numbers we'll never manage to comprehend.

<p align="center">
  <img src="/Screenshots/mergeOS-02.png" width="800" alt="'mergeOS' screenshot."
    style="filter: drop-shadow(0px 0px 10px rgba(0, 0, 0, .7));">
    <br/>
</p>

It's not about becoming better - it's all about being inhumanly, incoherently, and impossibly efficient. The idea of performance management or the questions surrounding "why keeping score is so important" mean nothing, as our industry, similarly to the video games one, is obviously hit-driven: all that matters is an application, tool, or game blowing up, but no one tells you all the things you'll lose while walking through that valley.

Increased numbers, increased speed, with no security granting us that even with that, we won't be fired, ignored, or simply replaceable. Do more, be more. Do it _now._ In this context, these thoughts made me work on **a tool I could privately use to improve my productivity** - because **nothing is enough**. That's how [mergeOS](https://github.com/JuditKaramazov/mergeOS/releases/download/v1.0.0/mergeOS.zip), **a MacBook shortcut allowing users to easily preview, manage, and access their development responsibilities**, was born. Another "unwanted child", like Kuning's one. 

What a time to be alive! Don't complain, though. Keep working.

---

## 🔮 Features

Now that I took the time to go `r/TrueOffMyChest`-style, it would be appropriate to remember that _not everything is as terrible as it seems,_ of course. Not even this little application is _that_ terrible! Do you want to discover why? Let's discuss its `main features`, then.

### 🍭 Easy to use

Accessibility has always been one of my main goals, no matter if I was developing something for others _or_ my own pleasure and entertainment. Considering this, I tried to **simplify all the functionalities and authentication steps** as much as possible for **mergeOS**, which resulted in the following requirements:

1. Download, unzip, and install the [latest release](https://github.com/JuditKaramazov/mergeOS/releases/tag/v1.0.0).
2. With the app open, go to `Authentication`.
3. Enter your **GitHub username**.
4. [Generate a GitHub access token](https://github.com/settings/tokens/new?scopes=repo) with **repo scope**.
5. **Enter your token**.

<p align="center">
  <img src="/Screenshots/mergeOS-03.png" width="900" alt="'mergeOS' screenshot.">
    <br/>
</p>

After that, and once you've accessed the `Settings...` option, you'll find the following sections:

- `General` settings, where you can **choose the build information and labels displayed**, the **pull requests you'd want to visualize**, the **refreshing rate**, or the **launch at login option**.
- `Shortcuts` settings.
- `Appearance` settings.

### ⏰ Automatized

Although it is possible to **manually refresh the application** by choosing the `Refresh...` option, it is also possible to `set a customized timer for the app to handle it automatically`:

- In the application, go to `Settings...`, `General`, and select the desired time in `Refresh rate` (1, 5, 10, 15 minutes...). This way, the application will **automatically fetch the data** and **update the information displayed on the screen**.

### 🐱 GitHub oriented

Yes, indeed: everything is about work, coding, and efficiency. As GitHub is my preferred tool, this application gravitates around The Nerd Cat™, its API, and our dearly-beloved pull requests: **created** or **assigned**, with their **check suites information**, **author**, **number of approvals**... and more!

<p align="center">
  <img src="/Screenshots/mergeOS-04.png" width="800" alt="'mergeOS' screenshot."
    style="filter: drop-shadow(0px 0px 10px rgba(0, 0, 0, .7));">
    <br/>
</p>

Also, and since I am aware of the existence of GitHub Enterprise, I made it possible to **select a custom endpoint URL** and not only the one set as default (`https://api.github.com`). For more information, you can check the [DefaultsExtensions.swift](/mergeOS/Extensions/DefaultsExtensions.swift) file, as well as all the files contained in the `/mergeOS/GitHub` folder.

### 🎨 Customizable display

Certainly, this application serves as **a shortcut to enhance users' productivity**, allowing them to **check their pending pull requests directly in their menu**. This fact doesn't mean, however, that we can't get slightly... _stylish_ here.

<p align="center">
  <img src="/Screenshots/mergeOS-05.png" width="800" alt="'mergeOS' screenshot."
    style="filter: drop-shadow(0px 0px 10px rgba(0, 0, 0, .7));">
    <br/>
</p>

- With mergeOS open, go to `Settings...`, `Appearance`, and select a `counter appearing near the icon` indicating the `assigned`, `created`, `review-requested` pull requests... or none at all! Also, feel free to make the app "yours" by choosing `your preferred menu icon` (the available options are the **pull request icon**, **GitHub's logo**, an **Octocat**... and a **suitcase**. We're discussing business here, guys.)

### ⌨️ Key bindings

Finally, and is it essential these days, it is also possible to **record your preferred shortcuts for the application's main functionalities**. In order to achieve it:

- Go to `Settings...`, `Shortcuts`, and input your desired combinations.

<p align="center">
  <img src="/Screenshots/mergeOS-06.png" width="800" alt="'mergeOS' screenshot."
    style="filter: drop-shadow(0px 0px 10px rgba(0, 0, 0, .7));">
    <br/>
</p>

If you are the curious type and would want to alter them manually, remember that you can always have a look at the [DefaultsExtensions.swift](/mergeOS/Extensions/DefaultsExtensions.swift) file, where you will find the following defaults:

```swift
  static let refreshKey = Key<String>("refreshKey", default: "r")
  static let settingsKey = Key<String>("settingsKey", default: "s")
  static let quitKey = Key<String>("quitKey", default: "q")
```

As well as the [AppDelegate.swift](/mergeOS/AppDelegate.swift) file, containing the key bindings for the rest of our menu footer items:

```swift
func addMenuFooterItems() {
  self.menu.addItem(withTitle: "Refresh", action: #selector(self.refreshMenu), keyEquivalent: Defaults[.refreshKey])
  let showAvatarMenuItem = NSMenuItem(title: "Show Avatar", action: #selector(self.toggleShowAvatar), keyEquivalent: "t")
  if showAvatar {
    showAvatarMenuItem.title = "Show Avatar ✓"
    }
  self.menu.addItem(showAvatarMenuItem)
  self.menu.addItem(.separator())
  self.menu.addItem(withTitle: "Settings...", action: #selector(self.openSettingsWindow), keyEquivalent: Defaults[.settingsKey])
  self.menu.addItem(withTitle: "About...", action: #selector(self.openAboutWindow), keyEquivalent: "a")
  self.menu.addItem(withTitle: "Quit", action: #selector(self.quit), keyEquivalent: Defaults[.quitKey])
}
```

---

## 💅 Style

Styling this application, which was intended to be quite a simple one, became... a nighmarish landscape. Just in case some of you are not aware of this problem Apple decided _not_ to address, `TabView` doesn't look like the `Settings Scene` without customization and workarounds, as you'll see if you have a look at the [SettingsView.swift](/mergeOS/Views/SettingsView.swift) file. However... we managed to make it work, guys! _More or less, at least._

As for the rest, and since I created this application thinking of **a tool that I myself would want to use**, I tried to respect GitHub's icons, colors, and aesthetic decisions as much as possible, just so that I could feel **mergeOS as an extension and not something merely external**. 

<p align="center">
  <img src="/Screenshots/mergeOS-07.png" width="500" alt="'mergeOS' screenshot."
    style="filter: drop-shadow(0px 0px 10px rgba(0, 0, 0, .7));">
    <br/>
</p>

Speaking of styles, and as it shouldn't surprise a single soul, [@AuNedelec](https://github.com/AuNedelec) was (_again!_) in charge of the application's main icon, which perfectly communicates the idea we had in mind while discussing the nature of **mergeOS**: a pull request icon combining both the emblematic macOS colors and the idea of a "shortcut". Thank you again for your talent, patience, and time. Sadly, some worries are taking more _mental space_ than they should, but believe it or not, I'm still trying my best to prevent burnout, worries, fear, and anxiety from taking the best of me. I hope you can see it...

---

## 🙌 Immense thanks to our awesome Sponsors

... and I also hope our incredible Sponsor, `@Entreprises LEMRHALI`, keeps in mind how `immensely grateful I am` - for everything! Although I must admit that I've been feeling _terribly low_ these recent times, I would also want you to remember that I am still trying my best, no matter the pain and "blue" moments trying to put my spirit down.

Soon, we will work on it around a nice tableboard game, though. It won't change our reality nor fix what feels like an unfixable matter, but if it can provide us with ["a moment's peace"](https://youtu.be/ja7dXwjIEKM?si=6FMZobU8oiAh0ob1), let's simply embrace it without questioning it, then. `¡Hay esperanza!`

<p align="center">
  <img src="https://raw.githubusercontent.com/JuditKaramazov/InsightsFromJuniorToFutureSeniors/main/images/lemrhali-logo.png" width="250" alt="Visual asset of a pixel-art weapon rack."
    style="filter: drop-shadow(0px 0px 10px rgba(0, 0, 0, .7));">
</p>

---

## 🏛 License & Copyright

This app lives under the beautiful and heartwarming roof of the [MIT License](LICENSE.txt). Independently of the freedom of usage (which should always respect the guidelines established in the [Code of conduct](CODE_OF_CONDUCT.md)), remember that you can always **open an issue for feature request porpuses or bug reports**. It is as simple as accessing [this link](https://github.com/JuditKaramazov/mergeOS/issues/new/choose), choosing your need, and communicate it to me.

Cooperation is essential these days, and building this together would make me more than happy! That said, and only if you enjoyed what you found here, remember that you can make the Dinosaur extremely happy if you...
<br />

---

<h1 align="center">
  <a href="https://karamazfolio.xyz/"><img src="https://raw.githubusercontent.com/JuditKaramazov/JuditKaramazfolio/a7b1825e33711948f51e53e249751761e1779f56/public/karamaBrand.png" width="100" height="100" alt="Original Karama logo asset.">
</h1>
<h2 align="center">
  <a href="https://www.buymeacoffee.com/JuditKaramazov" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 207px !important;" ></a>
</h2>
