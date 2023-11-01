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
  [#assign to = s?keep_after_last("/")]
  [#assign dashedFileNamed = to?replace(".","_")]
  [#assign UserCodeCounter = 0]
  
/* Private includes ----------------------------------------------------------*/
#include "main.h"
#include <stdlib.h>

/* we need generic include */

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

#define FIRST_COLOR     CYAN
#define SECOND_COLOR    RED

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

extern int16_t _width;                      ///< (oriented) display width
extern int16_t _height;                     ///< (oriented) display height

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

void ${fctName}(void)
{

/* USER CODE BEGIN ${fctName} 0 */

/* USER CODE END ${fctName} 0 */
  [#assign UserCodeCounter++]

  Displ_Init(Displ_Orientat_0);   // initialize the display and set the initial display orientation (here is orientaton: 0°) - THIS FUNCTION MUST PRECEED ANY OTHER DISPLAY FUNCTION CALL.
  Displ_CLS(BLACK);
 
  
/* USER CODE BEGIN ${fctName} 1 */

/* USER CODE END ${fctName} 1 */
  [#assign UserCodeCounter++]
  
}

/* USER CODE BEGIN Header_Process_Task */
/**
  * @brief  Function implementing the baseTask thread.
  * @param  argument: Not used
  * @retval None
  */
/* USER CODE END Header_Process_Task */
void ${fctProcessName}(void)
{
  uint16_t x,y,k,a,b;
  uint8_t c;

  for (k=0;k<2500;k++) {
    a=rand();
    b=rand();
    x=a % (_width-11) ;
    y=b % (_height-18) ;
    c=a % 26+'A';
    Displ_WChar(x, y, c, Font16, 1, FIRST_COLOR, SECOND_COLOR);
    x=b % (_width-11) ;
    y=a % (_height-18) ;
    c=b % 26+'A';
    Displ_WChar(x, y, c, Font16, 1, SECOND_COLOR, FIRST_COLOR);
    HAL_Delay(100);
  }
  
/* USER CODE BEGIN ${fctProcessName} 0 */

/* USER CODE END ${fctProcessName} 0 */
}

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */


/*******************  (C) TManiac Engineering  *******************/
/*******************         END OF FILE       *******************/
