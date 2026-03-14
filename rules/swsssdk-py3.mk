# swsssdk python3 wheel

SWSSSDK_PY3 = swsssdk-2.0.1-py3-none-any.whl
$(SWSSSDK_PY3)_SRC_PATH = $(SRC_PATH)/sonic-py-swsssdk
$(SWSSSDK_PY3)_PYTHON_VERSION = 3
$(SWSSSDK_PY3)_DEPENDS += $(REDIS_DUMP_LOAD_PY3)
# Tests require a running redis instance not available in the build slave.
# The package also lacks a [testing] extra, so test dependencies are never installed.
$(SWSSSDK_PY3)_TEST = n
ifeq ($(ENABLE_PY2_MODULES), y)
    # Synthetic dependency just to avoid race condition
    $(SWSSSDK_PY3)_DEPENDS += $(SWSSSDK_PY2)
endif
SONIC_PYTHON_WHEELS += $(SWSSSDK_PY3)
