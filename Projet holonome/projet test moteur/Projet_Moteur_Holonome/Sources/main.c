#include <hidef.h> /* for EnableInterrupts macro */
#include "derivative.h" /* include peripheral declarations */





void main(void) {
	int i=0;
	int a=0;
	int a=0;
  SRS_COP = 0 ;
  TPM1SC_CPWMS = 0;
  TPM1SC_PS0 = 0;
  TPM1SC_PS1 = 0;
  TPM1SC_PS2 = 1;
  TPM1C1SC_MS1A = 0;
  TPM1C1SC_MS1B = 0;
  TPM1C1SC_ELS1A = 1;
  TPM1C1SC_ELS1B = 0;
  TPM1C2SC_MS2A = 0;
    TPM1C2SC_MS2B = 0;
    TPM1C2SC_ELS2A = 1;
    TPM1C2SC_ELS2B = 0;
  

  for(i=0;i<=500;i++) 
  {

	  a = TPM1C1VL;
	  b = TPM1C1VH;
	 /* c = TPM1C2VH;
	  d = TPM1C2VL;*/
    
  } /* loop forever */
  /* please make sure that you never leave main */
}
