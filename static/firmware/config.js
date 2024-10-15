/* exported config */

var config = {
  // Show help text for images
  show_help: true,

  // Image download URL (e.g. "https://downloads.openwrt.org")
  image_url: "https://openwrt-download.czy21-internal.com",

  // Insert snapshot versions (optional)
  //show_snapshots: true,

  // Info link URL (optional)
  info_url: "https://openwrt.org/start?do=search&id=toh&q={title} @toh",

  // Attended Sysupgrade Server support (optional)
  asu_url: "https://sysupgrade.openwrt.org",
  asu_extra_packages: ["luci"],
};
