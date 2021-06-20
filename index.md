# Setting up the iOS SDK

An example project is [available here](https://github.com/InviteeCo/invitee-ios-docs/tree/main/Sample%20Project)
Follow the steps below to setup the invitee sdk in your existing project.


### Podfile

Install the invitee sdk & its dependencies

```markdown
pod 'Invitee'
```

### Info.plist

Add your api key & allow contacts access.
If you haven't generated an api key before, you can create from within the [web dashboard](https://app.invitee.co/account/api-keys)

```markdown
<key>NSContactsUsageDescription</key>
<string>Allow contacts so you can send invites</string>
<key>Invitee API Key</key>
<string>YOUR-API-KEY</string>
```

### Setup a user

Calling setup user is the first step. You should call this as soon as a user is logged in. This will add a user to a campaign if one is available & fetch information about the campaign, which you can then show in your UI

```markdown
private let user = User(customerId: "abcd-1234-abcd-1234", firstName: "John", lastName: "Appleseed", phoneNumber: "0412345678")

InviteeClient.shared.setup(for: user) { [weak self] maybeCampaign in
    guard let weakself = self, let campaign = maybeCampaign else { return }
    // show the referral information & a CTA to present the campaign overview page
}
```

### Present campaign overview page

The campaign overview page shows information to a user about the current referral campaign they are in & allows them to send invites to their friends.
The information seen on this page reflects what you have setup for that campaign in the web dashboard.

```markdown
InviteeClient.shared.present(on: self) // where self is a UIViewController
```

### Present referral notifications

When users signup both the referrer & referee can be notified about who of their friends signed up & what reward they earned.
Call this on a UIViewController where you want to present these popups.

```markdown
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    InviteeClient.shared.presentNotificationIfNeeded()
}
```
