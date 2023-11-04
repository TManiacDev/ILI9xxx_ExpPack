[#ftl]
[#assign fileName = "BSP_ILI9xxx"]
/**
  ******************************************************************************
  * @file  : ${fileName}.h
  * @brief : header file for the BSP SPI TFT display
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
      [#default]
        [#break]
    [/#switch] [#-- endof switch ipName --]
[/#list] 

#ifdef __cplusplus
 extern "C" {
#endif 

/* Includes ------------------------------------------------------------------*/ 
#include "fonts.h"

/* private Includes -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]
  
/*||||||||||| USER/PROJECT PARAMETERS |||||||||||*/
#include "BSP_ILI9xxx_Cfg.h"
/*|||||||| END OF USER/PROJECT PARAMETERS ||||||||*/

[#if Display_Port_Handle??]
/*************    BSP Connection    ***************
 ************* SPI PORT PARAMETERS *****************
 ** properly set the below th 2 defines to address
 ********  the SPI port defined on CubeMX *********
 **************************************************/
#define DISPL_SPI_PORT 	${Display_Port_Handle}
#define DISPL_SPI 		  ${Display_Port}
[/#if]     

/*************** GPIO Connection ******************/
[#if Display_CS_Pin??]
/************* Display Chip Select ****************/
#define DISPL_CS_Pin          ${Display_CS_Pin}
#define DISPL_CS_GPIO_Port    ${Display_CS_Port}
[/#if]

[#if Display_DC_Pin??]
/************ Display Data/Command ****************/
#define DISPL_DC_Pin          ${Display_DC_Pin}
#define DISPL_DC_GPIO_Port    ${Display_DC_Port}
[/#if]

/************ Display Reset ****************/
[#if Display_RST_Pin??]
#define DISPL_RST_Pin          ${Display_RST_Pin}
#define DISPL_RST_GPIO_Port    ${Display_RST_Port}
[#else]
#define DISPL_WITHOUT_RST
[/#if]

/************ Display Backlight ****************/
[#if Display_BL_Pin??]
#define DISPL_BL_Pin          ${Display_BL_Pin}
#define DISPL_BL_GPIO_Port    ${Display_BL_Port}
[#else]
#define DISPL_WITHOUT_BACKLIGHT
[/#if]

/* private Defines -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]
  
/************* Include the old header *************/
/******   this header needs defines above *********/
#include "z_displ_ILI9xxx.h"

/* private Includes -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]
  
#ifdef __cplusplus
}
#endif

#endif /*__ ${inclusion_protection}_H */
    
/*******************  (C) TManiac Engineering  *******************/
/*******************         END OF FILE       *******************/