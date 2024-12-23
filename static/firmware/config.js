/* exported config */

var config = {
  // Show help text for images
  show_help: true,

  // Image download URL (e.g. "https://downloads.openwrt.org")
  image_url: "https://openwrt-download.czy21.com",

  // Insert snapshot versions (optional)
  show_snapshots: true,

  // Info link URL (optional)
  info_url: "https://openwrt.org/start?do=search&id=toh&q={title} @toh",

  // Attended Sysupgrade Server support (optional)
  asu_url: "https://openwrt-asu.czy21.com",
  asu_extra_packages: ["luci"],
};
