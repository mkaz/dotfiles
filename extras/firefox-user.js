// Firefox user.js settings
// Copy file to your Firefox profile directory see about:support for location.
// This file is loaded each time Firefox starts overriding any settings in prefs.js
// Changes in about:config update prefs.js, they will not automatically be saved here
//
// See: http://kb.mozillazine.org/User.js_file

// disable RTC
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.use_document_iceservers", false);

user_pref("privacy.donottrackheader.enabled", true)
user_perf("privacy.trackingprotection.enabled", true)

user_pref("geo.enabled", false)
user_pref("geo.wifi.uri", "")
user_pref("browser.search.geoip.url", "")

user_pref("toolkit.telemetry.enabled", false)
user_pref("toolkit.telemetry.server", "")


// Printer Settings Default off
user_pref("print.print_footerleft", "");
user_pref("print.print_footerright", "");
user_pref("print.print_headerleft", "");
user_pref("print.print_headerright", "");

// improve YouTube Performance
user_pref("layers.acceleration.force-enabled", true );

// Disable web notifications
user_pref("dom.webnotifications.enabled", false);
