# This file is based on the Makefile automagically generated by mbed.org. 
# For more information, see http://mbed.org/handbook/Exporting-to-GCC-ARM-Embedded

EXAMPLE = $(TARGET)
OBJECTS = ./$(EXAMPLE)/main.o ./utils/utils.o
SYS_OBJECTS = ../../libs/mbed/TARGET_LPC1768/TOOLCHAIN_GCC_ARM/retarget.o ../../libs/mbed/TARGET_LPC1768/TOOLCHAIN_GCC_ARM/system_LPC17xx.o ../../libs/mbed/TARGET_LPC1768/TOOLCHAIN_GCC_ARM/board.o ../../libs/mbed/TARGET_LPC1768/TOOLCHAIN_GCC_ARM/cmsis_nvic.o ../../libs/mbed/TARGET_LPC1768/TOOLCHAIN_GCC_ARM/startup_LPC17xx.o 
MBED_INCLUDE_PATHS = -I../../libs/mbed -I../../libs/mbed/TARGET_LPC1768 -I../../libs/mbed/TARGET_LPC1768/TOOLCHAIN_GCC_ARM -I../../libs/mbed/TARGET_LPC1768/TARGET_NXP -I../../libs/mbed/TARGET_LPC1768/TARGET_NXP/TARGET_LPC176X -I../../libs/mbed/TARGET_LPC1768/TARGET_NXP/TARGET_LPC176X/TARGET_MBED_LPC1768
FREERTOS_INCLUDE_PATHS =  -I../../libs/FreeRTOS/include -I../../libs/FreeRTOS/portable
INCLUDE_PATHS = -I./$(EXAMPLE)/ $(FREERTOS_INCLUDE_PATHS) $(MBED_INCLUDE_PATHS) -I./utils/ -I../../slack/$(FREERTOS_KERNEL_VERSION_NUMBER)
LIBRARY_PATHS = -L../../libs/mbed/TARGET_LPC1768/TOOLCHAIN_GCC_ARM -L../../libs/freertos
LIBRARIES = -lmbed -lfreertos
LINKER_SCRIPT = ./LPC1768.ld

ifeq ($(TZ), 1)
  INCLUDE_PATHS += -I../../libs/Tracealizer/Include -I../../libs/Tracealizer/ConfigurationTemplate
endif

CPU = -mcpu=cortex-m3 -mthumb
CC_FLAGS = $(CPU) -c -g -fno-common -fmessage-length=0 -Wall -fno-exceptions -ffunction-sections -fdata-sections -fomit-frame-pointer -fno-rtti
CC_FLAGS += -MMD -MP
CC_SYMBOLS = -DTARGET_LPC1768 -DTARGET_M3 -DTARGET_NXP -DTARGET_LPC176X -DTARGET_MBED_LPC1768 -DTOOLCHAIN_GCC_ARM -DTOOLCHAIN_GCC -D__CORTEX_M3 -DARM_MATH_CM3 -DMBED_BUILD_TIMESTAMP=1414254042.69 -D__MBED__=1 -DBATCH_TEST=$(BATCH_TEST) -DMAX_PRIO=$(MAX_PRIO)

LD_FLAGS = -mcpu=cortex-m3 -mthumb -Wl,--gc-sections -u _printf_float -u _scanf_float
LD_SYS_LIBS = -lstdc++ -lsupc++ -lm -lc -lgcc -lnosys

ifeq ($(DEBUG), 1)
  CC_FLAGS += -DDEBUG -O0
else
  CC_FLAGS += -DNDEBUG -Os
endif

all: out/$(EXAMPLE).bin

generate_rtos: $(EXAMPLE).elf
	$(OBJCOPY) -O binary $< $(RTOS_BIN_NAME)

clean:
	rm -f out/$(EXAMPLE).bin out/$(EXAMPLE).elf $(OBJECTS) $(DEPS)

install:
	 cp $(EXAMPLE).bin /cygdrive/g/

.s.o:
	$(AS) $(CPU) -o $@ $<

.c.o:
	$(CC)  $(CC_FLAGS) $(CC_SYMBOLS) -std=gnu99   $(INCLUDE_PATHS) -o $@ $<

.cpp.o:
	$(CPP) $(CC_FLAGS) $(CC_SYMBOLS) -std=gnu++98 $(INCLUDE_PATHS) -o $@ $<


out/$(EXAMPLE).elf: $(OBJECTS) $(SYS_OBJECTS)
	$(LD) $(LD_FLAGS) -T$(LINKER_SCRIPT) $(LIBRARY_PATHS) -o $@ $^ $(LIBRARIES) $(LD_SYS_LIBS)

out/$(EXAMPLE).bin: out/$(EXAMPLE).elf
	$(OBJCOPY) -O binary $< $@

DEPS = $(OBJECTS:.o=.d) $(SYS_OBJECTS:.o=.d)
-include $(DEPS)