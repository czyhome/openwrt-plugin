include $(TOPDIR)/rules.mk

PKG_NAME:=python-ldap
PKG_VERSION:=3.4.3
PKG_RELEASE:=1

PYPI_NAME:=python-ldap
PKG_HASH:=ab26c519a0ef2a443a2a10391fa3c5cb52d7871323399db949ebfaa9f25ee2a0

PKG_MAINTAINER:=Bruce Chen <a805899926@gmail.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENCE.MIT

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-ldap
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  DEPENDS:=+libopenldap +python3
  TITLE:=Python Ldap Client
  URL:=https://www.python-ldap.org
endef

define Package/python3-ldap/description
  Python Ldap Client
endef

define Build/Compile
	$(call Build/Compile/PyMod,,build_ext \
		--include-dirs="$(STAGING_DIR)/usr/include:$(STAGING_DIR)/usr/include/sasl" \
		--library-dirs="$(STAGING_DIR)/usr/lib:$(STAGING_DIR)/usr/lib/sasl2" \
	build_py \
	install --prefix="$(PKG_INSTALL_DIR)/usr")
endef

define PyPackage/python-ldap/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
	    $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
	    $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call Py3Package,python3-ldap))
$(eval $(call BuildPackage,python3-ldap))