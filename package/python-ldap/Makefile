include $(TOPDIR)/rules.mk

PKG_NAME:=python-ldap
PKG_VERSION:=3.4.3
PKG_RELEASE:=1

PYPI_NAME:=python-ldap
PKG_HASH:=ab26c519a0ef2a443a2a10391fa3c5cb52d7871323399db949ebfaa9f25ee2a0

PKG_MAINTAINER:=Bruce Chen <a805899926@gmail.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENCE.MIT

include ../pypi.mk
include $(INCLUDE_DIR)/package.mk
include ../python3-package.mk

define Package/python3-ldap
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python Ldap Client
  URL:=https://github.com/python-ldap/python-ldap
endef

define Package/python3-ldap/description
  Python Ldap Client
endef

$(eval $(call Py3Package,python3-ldap))
$(eval $(call BuildPackage,python3-ldap))
$(eval $(call BuildPackage,python3-ldap-src))
