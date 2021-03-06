/******************************************************************************
 *
 * Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Use of the Software is limited solely to applications:
 * (a) running on a Xilinx device, or
 * (b) that interact with a Xilinx device through a bus or interconnect.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * XILINX CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
 * OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * Except as contained in this notice, the name of the Xilinx shall not be used
 * in advertising or otherwise to promote the sale, use or other dealings in
 * this Software without prior written authorization from Xilinx.
 *
 ******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "time_utils.h"
#include "myip.h"
#include "xuartps.h"	// if PS uart is used

#define BRAM_MEMORY1 0x40000000
#define BRAM_MEMORY2 0x40010000
#define REG2STATEMASK 0x0000000F
#define ADD_VALID_RESULT_MASK 0x00000010
#define ADD_VALID_A_MASK 0x00000020
#define ADD_VALID_B_MASK 0x00000040
#define MUL_VALID_RESULT_MASK 0x00000080
#define MUL_VALID_A_MASK 0x00000100
#define MUL_VALID_B_MASK 0x00000200
#define CNT5_TH_MASK 0x00000400
#define CNT4_TH_MASK 0x00000800
#define CNT3_TH_MASK 0x00001000
#define CNT2_TH_MASK 0x00002000
#define CNT1_TH_MASK 0x00004000
#define CNT5_CE_MASK 0x00008000
#define CNT4_CE_MASK 0x00010000
#define CNT3_CE_MASK 0x00020000
#define CNT2_CE_MASK 0x00040000
#define CNT1_CE_MASK 0x00080000
#define RES_FPUS_MASK 0x00100000


XUartPs Uart_PS;		/* Instance of the UART Device */

//reg_2 <="00000000000"& res_fpus & cnt1_ce &cnt2_ce &cnt3_ce &cnt4_ce &cnt5_ce & cnt1_thresh0 & cnt2_thresh0 & cnt3_thresh0 & cnt4_thresh0 & cnt5_thresh0 & mul_valid_a & mul_valid_b & mul_valid_result & add_valid_a & add_valid_b & add_valid_result & reg2State;

//void print(char *str);

int main()
{
	init_platform();
	//1. SW Berechnung
	//Speicher reservieren und initilisieren
	float a[1024];
	float b[1024];

	float* bram_a = (float*)BRAM_MEMORY1;
	float* bram_b = (float*)BRAM_MEMORY2;

	unsigned long time_sw1, time_sw2;
	unsigned long time_hw1, time_hw2;
	int i;

	for (i = 1; i <= 1024; i++)
	{
		a[i-1] = i*1.02;
		b[i-1] = i* 0.004;
	}

	memcpy(bram_a, &a[0], 1024*sizeof(float));
	memcpy(bram_b, &b[0], 1024*sizeof(float));

	time_sw1 = getElapsedRuntimeUS();
	float c = 0;
	for (i = 0; i< 1024; i++)
	{
		c += a[i] * b[i];
	}

	time_sw2 =  getElapsedRuntimeUS();

	//MYIP_mWriteReg(BaseAddress, RegOffset, Data)
	//MYIP_mReadReg(BaseAddress, RegOffset)
	//MYIP_S_AXI_SLV_REG0_OFFSET
	unsigned int reg0, reg1, reg2;

	char reg2State, add_valid_result, add_valid_a, add_valid_b , mul_valid_result, mul_valid_a, mull_valid_b;
	char cnt1_th, cnt1_ce, cnt2_th, cnt2_ce,cnt3_th, cnt3_ce,cnt4_th, cnt4_ce,cnt5_th, cnt5_ce;
	char res_fpus;

	float reg3;

	// UART related definitions
	int Status;
	XUartPs_Config *Config;
	// Initialize UART
	// Look up the configuration in the config table, then initialize it.
	Config = XUartPs_LookupConfig(XPAR_PS7_UART_1_DEVICE_ID);
	if (NULL == Config) {
		return XST_FAILURE;
	}

	Status = XUartPs_CfgInitialize(&Uart_PS, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	uint8_t byte;
	while (!XUartPs_IsReceiveData(STDIN_BASEADDRESS));
	byte = XUartPs_ReadReg(STDIN_BASEADDRESS,
			XUARTPS_FIFO_OFFSET);
	XUartPs_Send(&Uart_PS, &byte, 1);

	reg2 = MYIP_mReadReg(XPAR_MYIP_0_S_AXI_BASEADDR, MYIP_S_AXI_SLV_REG2_OFFSET);

	xil_printf("reg2: %x\n\r", reg2);
	reg2State = reg2 & REG2STATEMASK; //0x0000000F
	add_valid_result= (reg2 & ADD_VALID_RESULT_MASK)>>4; //0x00000010
	add_valid_a= (reg2 & ADD_VALID_A_MASK)>>5; //0x00000020
	add_valid_b= (reg2 & ADD_VALID_B_MASK)>>6; //0x00000040
	mul_valid_result= (reg2 & MUL_VALID_RESULT_MASK)>>7; //0x00000080
	mul_valid_a= (reg2 & MUL_VALID_A_MASK)>>8; //0x00000100
	mull_valid_b= (reg2 & MUL_VALID_B_MASK)>>9; //0x00000200
	cnt5_th= (reg2 & CNT5_TH_MASK)>>10; //0x00000400
	cnt4_th= (reg2 & CNT4_TH_MASK)>>11; //0x00000800
	cnt3_th= (reg2 & CNT3_TH_MASK)>>12; //0x00001000
	cnt2_th= (reg2 & CNT2_TH_MASK)>>13; //0x00002000
	cnt1_th= (reg2 & CNT1_TH_MASK)>>14; //0x00004000
	cnt5_ce= (reg2 & CNT5_CE_MASK)>>15; //0x00008000
	cnt4_ce= (reg2 & CNT4_CE_MASK)>>16; //0x00010000
	cnt3_ce= (reg2 & CNT3_CE_MASK)>>17; //0x00020000
	cnt2_ce= (reg2 & CNT2_CE_MASK)>>18; //0x00040000
	cnt1_ce= (reg2 & CNT1_CE_MASK)>>19; //0x00080000
	res_fpus= (reg2 & RES_FPUS_MASK)>>20; //0x00100000

	if (reg2State == 1)
	{
		time_hw1 = getElapsedRuntimeUS();
		MYIP_mWriteReg(XPAR_MYIP_0_S_AXI_BASEADDR, MYIP_S_AXI_SLV_REG0_OFFSET, 0x00000001);
	}

	//reg2 = MYIP_mReadReg(XPAR_MYIP_0_S_AXI_BASEADDR, MYIP_S_AXI_SLV_REG2_OFFSET);
	//MYIP_mWriteReg(XPAR_MYIP_0_S_AXI_BASEADDR, MYIP_S_AXI_SLV_REG0_OFFSET, 0x00000000);
	//while (reg2State != 3)
	for (i = 0; i < 3; i++)
	{
		reg2 = MYIP_mReadReg(XPAR_MYIP_0_S_AXI_BASEADDR, MYIP_S_AXI_SLV_REG2_OFFSET);
		xil_printf("reg2: %x\n\r", reg2);
		reg2State = reg2 & REG2STATEMASK; //0x0000000F
		add_valid_result= (reg2 & ADD_VALID_RESULT_MASK)>>4; //0x00000010
		add_valid_a= (reg2 & ADD_VALID_A_MASK)>>5; //0x00000020
		add_valid_b= (reg2 & ADD_VALID_B_MASK)>>6; //0x00000040
		mul_valid_result= (reg2 & MUL_VALID_RESULT_MASK)>>7; //0x00000080
		mul_valid_a= (reg2 & MUL_VALID_A_MASK)>>8; //0x00000100
		mull_valid_b= (reg2 & MUL_VALID_B_MASK)>>9; //0x00000200
		cnt5_th= (reg2 & CNT5_TH_MASK)>>10; //0x00000400
		cnt4_th= (reg2 & CNT4_TH_MASK)>>11; //0x00000800
		cnt3_th= (reg2 & CNT3_TH_MASK)>>12; //0x00001000
		cnt2_th= (reg2 & CNT2_TH_MASK)>>13; //0x00002000
		cnt1_th= (reg2 & CNT1_TH_MASK)>>14; //0x00004000
		cnt5_ce= (reg2 & CNT5_CE_MASK)>>15; //0x00008000
		cnt4_ce= (reg2 & CNT4_CE_MASK)>>16; //0x00010000
		cnt3_ce= (reg2 & CNT3_CE_MASK)>>17; //0x00020000
		cnt2_ce= (reg2 & CNT2_CE_MASK)>>18; //0x00040000
		cnt1_ce= (reg2 & CNT1_CE_MASK)>>19; //0x00080000
		res_fpus= (reg2 & RES_FPUS_MASK)>>20; //0x00100000
		xil_printf("reg2State: %d\n\r", reg2State);
		xil_printf("add_valid_result: %d\n\r", (int)add_valid_result);
		xil_printf(	"add_valid_a: %d\n\r", (int)add_valid_a);
		xil_printf(	"add_valid_b: %d\n\r", (int)add_valid_b);
		xil_printf(	"mul_valid_result: %d\n\r", (int)mul_valid_result);
		xil_printf(	"mul_valid_a: %d\n\r", (int)mul_valid_a);
		xil_printf(	"mull_valid_b: %d\n\r", (int)mull_valid_b);

		xil_printf("cnt1_th: %d, cnt1_ce: %d, cnt2_th: %d, cnt2_ce: %d,cnt3_th: %d, cnt3_ce: %d,cnt4_th: %d, cnt4_ce: %d,cnt5_th: %d, cnt5_ce: %d",
				cnt1_th, cnt1_ce, cnt2_th, cnt2_ce,cnt3_th, cnt3_ce,cnt4_th, cnt4_ce,cnt5_th, cnt5_ce);
		xil_printf("res_fpus: %d\n\r", res_fpus);
	}
	reg3 = (float)MYIP_mReadReg(XPAR_MYIP_0_S_AXI_BASEADDR, MYIP_S_AXI_SLV_REG2_OFFSET);
	time_hw2 = getElapsedRuntimeUS();

	while(1)
	{
		xil_printf("Needed time sw: %d\n\r", time_sw2-time_sw1);
		xil_printf("C sw: %f ", c);
		xil_printf("Needed time hw: %d\n\r", time_sw2-time_sw1);
		xil_printf("C hw: %f ", reg3);
		usleep(10000);
	}

	//2. HW Berechnung
	//BRAM Werte eintragen



	//print("Needed time:\n\r");

	cleanup_platform();
	return 0;
}
