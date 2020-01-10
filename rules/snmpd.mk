# snmpd package

SNMPD_VERSION = 5.8+dfsg
SNMPD_VERSION_FULL = $(SNMPD_VERSION)-2

export SNMPD_VERSION SNMPD_VERSION_FULL

LIBSNMP_BASE = libsnmp-base_$(SNMPD_VERSION_FULL)_all.deb
$(LIBSNMP_BASE)_SRC_PATH = $(SRC_PATH)/snmpd
$(LIBSNMP_BASE)_DEPENDS += $(LIBNL3_DEV) $(LIBSENSORS_DEV)
$(LIBSNMP_BASE)_RDEPENDS += $(LIBNL3) $(LIBSENSORS)
SONIC_MAKE_DEBS += $(LIBSNMP_BASE)

SNMPTRAPD = snmptrapd_$(SNMPD_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(SNMPTRAPD)_DEPENDS += $(LIBSNMP) $(SNMPD)
$(SNMPTRAPD)_RDEPENDS += $(LIBSNMP) $(SNMPD)
$(eval $(call add_derived_package,$(LIBSNMP_BASE),$(SNMPTRAPD)))

SNMP = snmp_$(SNMPD_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(SNMP)_DEPENDS += $(LIBSNMP)
$(SNMP)_RDEPENDS += $(LIBSNMP)
$(eval $(call add_derived_package,$(LIBSNMP_BASE),$(SNMP)))

SNMPD = snmpd_$(SNMPD_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(SNMPD)_DEPENDS += $(LIBSNMP)
$(SNMPD)_RDEPENDS += $(LIBSNMP)
$(eval $(call add_derived_package,$(LIBSNMP_BASE),$(SNMPD)))

SNMP_DBG = snmp-dbgsym_$(SNMPD_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(eval $(call add_derived_package,$(SNMP),$(SNMP_DBG)))

SNMPD_DBG = snmpd-dbgsym_$(SNMPD_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(eval $(call add_derived_package,$(SNMPD),$(SNMPD_DBG)))

LIBSNMP = libsnmp35_$(SNMPD_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(LIBSNMP)_RDEPENDS += $(LIBSNMP_BASE)
$(eval $(call add_derived_package,$(LIBSNMP_BASE),$(LIBSNMP)))

LIBSNMP_DBG = libsnmp35-dbg_$(SNMPD_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(LIBSNMP_DBG)_DEPENDS += $(LIBSNMP)
$(LIBSNMP_DBG)_RDEPENDS += $(LIBSNMP)
$(eval $(call add_derived_package,$(LIBSNMP_BASE),$(LIBSNMP_DBG)))

LIBSNMP_DEV = libsnmp-dev_$(SNMPD_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(LIBSNMP_DEV)_DEPENDS += $(LIBSNMP)
$(eval $(call add_derived_package,$(LIBSNMP_BASE),$(LIBSNMP_DEV)))

LIBSNMP_PERL = libsnmp-perl_$(SNMPD_VERSION_FULL)_$(CONFIGURED_ARCH).deb
$(LIBSNMP_PERL)_DEPENDS += $(LIBSNMP)
$(LIBSNMP_PERL)_RDEPENDS += $(LIBSNMP)
$(eval $(call add_derived_package,$(LIBSNMP_BASE),$(LIBSNMP_PERL)))

TKMIB = tkmib_$(SNMPD_VERSION_FULL)_all.deb
$(TKMIB)_DEPENDS += $(LIBSNMP_PERL)
$(TKMIB)_RDEPENDS += $(LIBSNMP_PERL)
$(eval $(call add_derived_package,$(LIBSNMP_BASE),$(TKMIB)))

# The .c, .cpp, .h & .hpp files under src/{$DBG_SRC_ARCHIVE list}
# are archived into debug one image to facilitate debugging.
#
DBG_SRC_ARCHIVE += snmpd

