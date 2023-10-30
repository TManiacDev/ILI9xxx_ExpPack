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
[/#list] 

[#assign Display_Port_Handle = "h" + IpInstance?lower_case ]
[#assign Display_Port = IpInstance ]
        
#ifdef __cplusplus
 extern "C" {
#endif 

/* Includes ------------------------------------------------------------------*/ 
#include "fonts.h"

/*||||||||||| USER/PROJECT PARAMETERS |||||||||||*/
#include "BSP_ILI9xxx_Cfg.h"
/*|||||||| END OF USER/PROJECT PARAMETERS ||||||||*/

/*************    BSP Connection    ***************
 **************** PORT PARAMETERS *****************
 ** properly set the below th 2 defines to address
 ********  the SPI port defined on CubeMX *********
 **************************************************/
#define DISPL_SPI_PORT 	${Display_Port_Handle}
#define DISPL_SPI 		  ${Display_Port}

#include "z_displ_ILI9xxx.h"
  

#ifdef __cplusplus
}
#endif

#endif /*__ ${inclusion_protection}_H */
    
/*******************  (C) TManiac Engineering  *******************/
/*******************         END OF FILE       *******************/