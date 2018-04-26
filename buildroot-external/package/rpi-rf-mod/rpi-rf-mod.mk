#############################################################
#
# Support for RPI-RF-MOD RF-Module
#
#############################################################

RPI_RF_MOD_VERSION = 2.9.4
RPI_RF_MOD_SITE = $(BR2_EXTERNAL)/package/rpi-rf-mod
RPI_RF_MOD_SITE_METHOD = local

define RPI_RF_MOD_BUILD_CMDS
  for dts in $(@D)/dts/*.dts; do \
    $(HOST_DIR)/bin/dtc -@ -I dts -O dtb -W no-unit_address_vs_reg -o $${dts%.dts}.dtbo $${dts}; \
  done
endef

define RPI_RF_MOD_INSTALL_TARGET_CMDS
  cp -a $(@D)/rootfs-overlay/* $(TARGET_DIR)/
  for dtbo in $(@D)/dts/*.dtbo; do \
    $(INSTALL) -D -m 0644 $${dtbo} $(BINARIES_DIR)/; \
  done
endef

$(eval $(generic-package))
