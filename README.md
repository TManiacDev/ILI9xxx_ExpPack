# STM32Cube Expansion Pack for ILI9xxx SPI-TFT Display
This is a [STM32ExpansionPack](https://wiki.st.com/stm32mcu/wiki/Introduction_to_STM32Cube_Expansion_Packages) for TFT displays connect via SPI.
The pack is based on the driver from https://github.com/maudeve-it/ILI9XXX-XPT2046-STM32/
This pack is for the display only, there will be a second pack for the touch controller.

## Dependencies
+ The software using the STM32Cube system based on the STM32 HAL.
+ Because of the use of gcc compiler inside the STM32CubeIDE, this is my compiler. Adds are welcome.
+ you must configure the following peripherals:
	+ SPI (SPI1)
	+ Timer (TIM3) -> Backlight PWM(PC7*)
	+ GPIO for CS (PD15), DC (PD14),  Reset (PE15*)
	
## Small changes against the based
+ Rework for independency to the touch panel
+ Removed timer dependencies for polling only mode (without TouchGFX)
+ If no back light isused, this will build without configuration needed.

## This isn't a compilable project at all
The including code is to build the ExpansionPack with the **STM32PackCreator**.  
There are some hand-made changes inside to use C++ instead of the plain-C. 
So be careful when you touching templates for code generation.

+ The "source" folder holds the source to build the STM32ExpansionPack (using the **STM32PackCreator**).  
+ The "pack" folder is the working directory of the **STM32PackCreator**. So it holds the creator project file and the prepared templates for code generation.
+ There will be compileable projects inside the "projects" folder. These projects are intend as tutorials of the expansion pack.   