[#ftl]
[#assign fileName = "BSP_ILI9xxx"]
/**
  ******************************************************************************
  * @file   ${fileName}.h
  * @brief  header file for the BSP SPI TFT display
  *
  [#assign aDateTime = .now]
  [#assign aDate = aDateTime?date]
  [#assign aTime = aDateTime?time]
  * Last updated       : ${aDate}  ${aTime}
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+ "/license.tmp"/][#--include License text --]
  ******************************************************************************
*/

[#assign s = fileName]
[#assign dashedFileNamed = s?replace(".","__")]
[#assign toto = dashedFileNamed?replace("/","__")]
[#assign dashReplace = toto?replace("-","_")]
[#assign inclusion_protection = dashReplace?upper_case]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${inclusion_protection}__
#define __${inclusion_protection}__

[#assign UserCodeCounter = 0]

[#assign IpInstance = ""]
[#assign IpName = ""]

[#list BspIpDatas as SWIP] 
    [#if SWIP.variables??]
        [#list SWIP.variables as variables]
            [#if variables.name?contains("IpInstance")]
                [#assign IpInstance = variables.value]
            [/#if]
            [#if variables.name?contains("IpName")]
                [#assign IpName = variables.value]
            [/#if]	
            [#if variables.name?contains("INSTANCE_NUMBER")]
                [#assign InstNumber = variables.value]
				
            [/#if]
        [/#list]
    [/#if]
    [#switch SWIP.ipName]
      [#case "SPI"]
[#assign Display_Port_Handle = "h" + IpInstance?lower_case ]
[#assign Display_Port = IpInstance ]
        [#break]
      [#case "Chip Select"]
[#assign Display_CS_Pin = IpInstance ]
[#assign Display_CS_Port = IpName ]
        [#break]
      [#case "Data Command"]
[#assign Display_DC_Pin = IpInstance ]
[#assign Display_DC_Port = IpName ]
        [#break]
      [#case "Display Reset"]
[#assign Display_RST_Pin = IpInstance ]
[#assign Display_RST_Port = IpName ]
        [#break]
      [#case "Backlight Switch"]
[#assign Display_BL_Pin = IpInstance ]
[#assign Display_BL_Port = IpName ]
        [#break]
      [#case "Sync Timer"]
[#assign TouchGFX_SyncTimer = IpInstance ]
// ${SWIP}
        [#break]
      [#default]
        [#break]
    [/#switch] [#-- endof switch ipName --]
[/#list] 

/** defgroup BSP Board Support Package
  * @{
  */

/** defgroup ILI9XXX ILI9xxx based SPI TFT */

/** * @} */ // end of defgroup BSP

/** @addtogroup ILI9XXX
  * @{
  */

/** @defgroup ILI9XXX_Includes ILI9xxx Includes */
/** @defgroup ILI9XXX_Private_Defines ILI9xxx Defines */
/** @defgroup ILI9XXX_Config_Defines ILI9xxx Configuration Defines */
/** @defgroup ILI9XXX_Macro_Defines ILI9xxx Macro Defines */

/** @defgroup ILI9XXX_Platform_Defines ILI9xxx Platform Defines
 *  @brief This Defines are the connections to the hardware peripherals */

/** @defgroup ILI9XXX_Public_Function Interface Functions
 *  @brief Functions to use the module */
/** @defgroup ILI9XXX_HAL_Function HAL Functions
 *  @brief HAL Callback functions */

/** * @}  */ // end of addtogroup ILI9XXX

#ifdef __cplusplus
 extern "C" {
#endif 

/* Includes ------------------------------------------------------------------*/ 
/** @addtogroup ILI9XXX_Includes 
 *  @{ */
#include "fonts.h"

/* private Includes -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]

/** * @}  */ // end of addtogroup ILI9XXX_Includes 

/*||||||||||| USER/PROJECT PARAMETERS |||||||||||*/
#include "BSP_ILI9xxx_Cfg.h"
/*|||||||| END OF USER/PROJECT PARAMETERS ||||||||*/

/** @addtogroup ILI9XXX_Platform_Defines 
 * @{ 
 */ 
 
[#if Display_Port_Handle??]
/*************    BSP Connection    ***************
 ************* SPI PORT PARAMETERS *****************
 ** properly set the below th 2 defines to address
 ********  the SPI port defined on CubeMX *********
 **************************************************/
/** @brief Define to hold the handle of the connected SPI */
#define DISPL_SPI_PORT 	${Display_Port_Handle}
/** @brief Define to name the connected SPI */
#define DISPL_SPI 		  ${Display_Port}
[/#if]     

/*************** GPIO Connection ******************/
[#if Display_CS_Pin??]
/************* Display Chip Select ****************/
/** @brief Define to hold the pin name of the chip select line */
#define DISPL_CS_Pin          ${Display_CS_Pin}
/** @brief Define to hold the pin port name of the chip select line */
#define DISPL_CS_GPIO_Port    ${Display_CS_Port}
[/#if]

[#if Display_DC_Pin??]
/************ Display Data/Command ****************/
/** @brief Define to hold the pin name of the data/command line */
#define DISPL_DC_Pin          ${Display_DC_Pin}
/** @brief Define to hold the pin port name of the data/command line */
#define DISPL_DC_GPIO_Port    ${Display_DC_Port}
[/#if]

/************ Display Reset ****************/
[#if Display_RST_Pin??]
/** @brief Define to hold the pin name of the reset line */
#define DISPL_RST_Pin          ${Display_RST_Pin}
/** @brief Define to hold the pin port name of the reset line */
#define DISPL_RST_GPIO_Port    ${Display_RST_Port}
[#else]
/** @brief Define to show there is no reset line */
#define DISPL_WITHOUT_RST
[/#if]

/************ Display Backlight ****************/
[#if Display_BL_Pin??]
/** @brief Define to hold the pin name of the back light control line */
#define DISPL_BL_Pin          ${Display_BL_Pin}
/** @brief Define to hold the pin port name of the back light control line */
#define DISPL_BL_GPIO_Port    ${Display_BL_Port}
[#else]
/** @brief Define to show there is no back light control */
#define DISPL_WITHOUT_BACKLIGHT
[/#if]

[#if TouchGFX_SyncTimer??]
/** @brief     Enable TouchGFX interface */
#define DISPLAY_USING_TOUCHGFX
/** ***************  *****************
 * @brief          TouchGFX Time base timer
 
 * If using library in TouchGFX-full-mode
 * (see GitHub page indicated on top for details)
 * you have to set # define DELAY_TO_KEY_REPEAT -1
 * in "z_touch_XPT2046.h" and setup a timer as a 
 * time base for TouchGFX. 
 
 * It has to be set to generate a
 * HAL_TIM_PeriodElapsedCallback 60 times per second
 * That timer has to be assigned to the below macros.
 * if not in TouchGFX-full-mode: assign macros to 
 * an unused timer
 ***************************************************/
#define TGFX_TIMER			${TouchGFX_SyncTimer}
/** @brief To hold the handle name of the sync timer */
#define TGFX_T				h${TouchGFX_SyncTimer?lower_case}
[/#if]

/** @} */ // end of addtogroup ILI9XXX_Platform_Defines
 
/* private Defines -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]
  
/** @addtogroup ILI9XXX_Includes 
 *  @{ */
 
/************* Include the old header *************/
/******   this header needs defines above *********/
#include "z_displ_ILI9xxx.h"

/* private Includes -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]

/** * @}  */ // end of addtogroup ILI9XXX_Includes 

#ifdef __cplusplus
}
#endif

#endif /*__ ${inclusion_protection}_H */
    
/*******************  (C) TManiac Engineering  *******************/
/*******************         END OF FILE       *******************/