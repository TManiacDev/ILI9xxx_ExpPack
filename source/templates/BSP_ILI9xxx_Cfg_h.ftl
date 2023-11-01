[#ftl]
/**
  ******************************************************************************
  * File Name          : ${name}
  * Description        : This file provides code for the configuration
  *                      of the ${name} instances.
  *
  [#assign aDateTime = .now]
  [#assign aDate = aDateTime?date]
  [#assign aTime = aDateTime?time]
  * Last updated       : ${aDate}  ${aTime}
  *
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
[#assign s = name]
[#assign dashedFileNamed = s?replace(".","__")]
[#assign toto = dashedFileNamed?replace("/","__")]
[#assign dashReplace = toto?replace("-","_")]
[#assign inclusion_protection = dashReplace?upper_case]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${inclusion_protection}__
#define __${inclusion_protection}__

  [#assign UserCodeCounter = 0]
  
#ifdef __cplusplus
 extern "C" {
#endif

#include "main.h"

/* private Includes -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]

/*******************************/
[#-- SWIPdatas is a list of SWIPconfigModel --]  
[#list SWIPdatas as SWIP]  
[#assign instName = SWIP.ipName]   
[#assign fileName = SWIP.fileName]   
[#assign version = SWIP.version]   
/** @file
	MiddleWare name : ${instName}
	MiddleWare fileName : ${fileName}
	MiddleWare version : ${version}
*/
/*******************************/
[#-- Global variables --]
[#if SWIP.variables??]
	[#list SWIP.variables as variable]
extern ${variable.value} ${variable.name};
	[/#list] [#-- endof #list SWIP.variables as variable --]
[/#if]

[#-- Global variables --]

[#if SWIP.defines??]
	[#list SWIP.defines as definition]  
  [#switch definition.name ]
    [#case "DISPLAY_USING_TOUCHGFX"]      
        [#if definition.value = "true"]
          [#assign USE_TOUCHGFX = true]
        [/#if]
      [#break]
    [#case "DISPLAY_TYP"]
        [#assign Display_Type = definition.value]
      [#break]
    [#case "DISPLAY_SPI_PORT"]
        [#-- assign Display_Port_Handle = definition.value?lower_case --]
        [#-- assign Display_Port = definition.value --]
        [#assign Display_Port_Handle = definition.value?lower_case]
        [#assign Display_Port = definition.value?remove_beginning("h")?upper_case]
      [#break]
    [#case "DISPL_PRESCALER"]
    [#case "DISPLAY_PRESCALER"]
        [#assign Display_Prescaler = definition.value]
      [#break]
    [#case "DISPLAY_SPI_MODE"]
        [#assign Display_SPI_Mode = definition.value]
      [#break]
    [#case "BUFLEVEL"]
    [#case "DISPLAY_BUFLEVEL"]
        [#assign Display_BufferSize = definition.value]
      [#break]
    [#default]
      [#if definition.comments??]
    /** ----------  ${definition.comments} -----------*/
      [#else]
    /** -------- generated Value  -----------*/ 
      [/#if]
#define ${definition.name} #t#t ${definition.value} 
      [#if definition.description??]${definition.description} [/#if]
  [/#switch] [#-- endof definition.name --]
	[/#list] [#-- endof #list SWIP.defines as definition --]
[/#if]
[/#list] [#-- endof #list SWIPdatas as SWIP --]

/* private defines -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]

/* private names -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]

/*****************     STEP 1      *****************
 ************ Enable TouchGFX interface ************
 * uncommenting the below #define to enable
 * functions interfacing TouchGFX
 ***************************************************/
[#if USE_TOUCHGFX??]
#define DISPLAY_USING_TOUCHGFX
[#else]
//#define DISPLAY_USING_TOUCHGFX
[/#if]


/******************    STEP 2    *****************
 * which display are you using?
 * ILI9341
 * ILI9488_V1
 * ILI9488_V2
 *************************************************/
#define ${Display_Type}


/******************    STEP 4     ******************
 ***************** SPI PORT SPEED  *****************
 * define HERE the prescaler value to assign SPI port 
 * when transferring data to/from DISPLAY or TOUCH
 * Keep in mind that Touch SPI Baudrate should be no more than 1 Mbps
 ***************************************************/
#define DISPL_PRESCALER SPI_BAUDRATEPRESCALER_${Display_Prescaler}     //prescaler assigned to display SPI port


/*****************     STEP 5      *****************
 ************* SPI COMMUNICATION MODE **************
 *** enable SPI mode want, uncommenting ONE row ****
 **** (Setup the same configuration on CubeMX) *****
 * DISPLAY_SPI_POLLING_MODE
 * DISPLAY_SPI_INTERRUPT_MODE
 * DISPLAY_SPI_DMA_MODE // (mixed: polling/DMA, see below)
 ***************************************************/
 #define DISPLAY_SPI_${Display_SPI_Mode}

/*****************     STEP 6      *****************
 ***************** Backlight timer *****************
 * if you want dimming backlight UNCOMMENT the
 * DISPLAY_DIMMING_MODE below define and properly
 * set other defines.
 * Using backlight as a switch (only on/off) leave
 * DISPLAY_DIMMING_MODE commented
 * if DIMMING:
 * On CubeMX set DISPL_LED pin as a timer PWM pin.
 * Timer COUNTER PERIOD (ARR) defines dimming light steps:
 * keep it low value - e.g. 10 - if dimming with buttons,
 * use higher value - e.g. 100 - if dimming with encoder, ...
 * Avoiding display flickering timer PRESCALER should
 * let timer clock to be higher than COUNTER PERIOD * 100 Hz.
 * Set all other defines below 
 ***************************************************/
//#define DISPLAY_DIMMING_MODE						// uncomment this define to enable dimming function otherwise there is an on/off switching function
#define BKLIT_TIMER 				TIM2			//timer used (PWMming DISPL_LED pin)
#define BKLIT_T 					htim2			//timer used
#define BKLIT_CHANNEL				TIM_CHANNEL_1	//channel used
#define BKLIT_CCR					CCR1			//Capture-compare register used (same number as channel)
#define BKLIT_STBY_LEVEL 			50				//Display backlight level when in stand-by (levels are CNT values)
#define BKLIT_INIT_LEVEL 			100				//Display backlight level on startup


/*****************     STEP 7      *****************
 ***************** TouchGFX Time base timer *****************
 * If using library in TouchGFX-full-mode
 * (see GitHub page indicated on top for details)
 * you have to set #define DELAY_TO_KEY_REPEAT -1
 * in "z_touch_XPT2046.h" and setup a timer as a 
 * time base for TouchGFX. 
 * It has to be set to generate a
 * HAL_TIM_PeriodElapsedCallback 60 times per second
 * That timer has to be assigned to the below macros.
 * if not in TouchGFX-full-mode: assign macros to 
 * an unused timer
 ***************************************************/
#define TGFX_TIMER			TIM3
#define TGFX_T				htim3


/*****************     STEP 8      *****************
 ************* frame buffer DEFINITION *************
 * IF NO TOUCHGFX: 
 * BUFLEVEL defines size of each one of the 2 SPI 
 * buffers: buffer size is 2^BUFLEVEL so 2 means 
 * 4 bytes buffer and 10 means 1 kbyte (each).
 * It must be not below 10!
 * If TOUCHGFX:
 * buffers are not used if display handles RGB565. 
 * If display uses RGB666 one buffer will be used for 
 * color format translation. In this case set
 * BUFLEVEL following this table:
 * TouchGFX buffers>10KB need BUFLEVEL 15
 * TouchGFX buffers>5KB  need BUFLEVEL 14
 * TouchGFX buffers>2700bytes need BUFLEVEL 13
 * TouchGFX buffers>1300bytes need BUFLEVEL 12
***************************************************/
#define BUFLEVEL ${Display_BufferSize}

#ifdef __cplusplus
}
#endif
#endif /*__ ${inclusion_protection}_H */

/*******************  (C) TManiac Engineering  *******************/
/*******************         END OF FILE       *******************/
