.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

MAIN_TARGET = iproute2_$(IPROUTE2_VERSION_SONIC)_$(CONFIGURED_ARCH).deb
DERIVED_TARGETS = iproute2-dbgsym_$(IPROUTE2_VERSION_SONIC)_$(CONFIGURED_ARCH).deb
SUFFIX = $(shell date +%Y%m%d.%H%M%S)
STG_BRANCH = stg_temp.$(SUFFIX)
IPROUTE2_TAG = v$(IPROUTE2_VERSION_BASE)
IPROUTE2_BRANCH = iproute2_build

$(addprefix $(DEST)/, $(MAIN_TARGET)): $(DEST)/% :
	# Build from submodule source
	pushd ./iproute2

	# Ensure clean state (handles previous failed builds)
	git checkout -- . 2>/dev/null || true
	git clean -xfdf
	git checkout $(IPROUTE2_TAG)
	git reset --hard $(IPROUTE2_TAG)
	git branch -D $(IPROUTE2_BRANCH) 2>/dev/null || true
	git checkout -b $(IPROUTE2_BRANCH) $(IPROUTE2_TAG)

	# Copy debian packaging directory into source tree
	cp -r ../debian .
	git add -f debian
	git commit -qm "Add debian packaging"

	# Apply SONiC patches via stg
	stg branch --create $(STG_BRANCH) HEAD
	stg import -s ../patch/series

	# Update version to match SONiC naming convention
	sed -i '1s/(.*)/($(IPROUTE2_VERSION_SONIC))/' debian/changelog

ifeq ($(CROSS_BUILD_ENVIRON), y)
	dpkg-buildpackage -rfakeroot -d -b -us -uc -a$(CONFIGURED_ARCH) -Pcross,nocheck -j$(SONIC_CONFIG_MAKE_JOBS) --admindir $(SONIC_DPKG_ADMINDIR)
else
	dpkg-buildpackage -rfakeroot -d -b -us -uc -j$(SONIC_CONFIG_MAKE_JOBS) --admindir $(SONIC_DPKG_ADMINDIR)
endif

	# Restore submodule to clean state
	git checkout -- .
	git clean -xfdf
	git checkout $(IPROUTE2_TAG)
	git reset --hard $(IPROUTE2_TAG)
	git branch -D $(IPROUTE2_BRANCH) 2>/dev/null || true
	popd

	mv $(DERIVED_TARGETS) $* $(DEST)/

$(addprefix $(DEST)/, $(DERIVED_TARGETS)): $(DEST)/% : $(DEST)/$(MAIN_TARGET)
