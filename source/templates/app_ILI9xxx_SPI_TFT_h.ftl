[#ftl]
/**
  ******************************************************************************
  * File Name          : ${name}
  * Description        : This file provides code for a simple Hello World application.
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

[#assign s = fctProcessName?keep_before_last("_")]
[#assign dashedFileNamed = s?replace("-","_")]
[#assign inclusion_protection = dashedFileNamed?upper_case]
[#assign UserCodeCounter = 0]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __${inclusion_protection}__
#define __${inclusion_protection}__

#ifdef __cplusplus
extern "C" {
#endif

/* private Includes -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]

/* Exported Functions --------------------------------------------------------*/
void ${fctName}(void);
void ${fctProcessName}(void);

/* private function -----------------------------------------------------------*/
/* USER CODE BEGIN ${dashedFileNamed} ${UserCodeCounter} */

/* USER CODE END ${dashedFileNamed} ${UserCodeCounter} */
  [#assign UserCodeCounter++]

#ifdef __cplusplus
}
#endif
#endif /*__ ${inclusion_protection} */

/*******************  (C) TManiac Engineering  *******************/
/*******************         END OF FILE       *******************/
