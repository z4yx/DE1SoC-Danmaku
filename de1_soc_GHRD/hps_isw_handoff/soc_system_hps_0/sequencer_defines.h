/*
Copyright (c) 2012, Altera Corporation
All rights reserved.

SPDX-License-Identifier:    BSD-3-Clause

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Altera Corporation nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL ALTERA CORPORATION BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
#ifndef _SEQUENCER_DEFINES_H_
#define _SEQUENCER_DEFINES_H_

#define AC_ROM_MR1_MIRR 0000000100100
#define AC_ROM_MR1_OCD_ENABLE 
#define AC_ROM_MR2_MIRR 0000000001000
#define AC_ROM_MR3_MIRR 0000000000000
#define AC_ROM_MR0_CALIB 
#define AC_ROM_MR0_DLL_RESET_MIRR 0010011001000
#define AC_ROM_MR0_DLL_RESET 0010100110000
#define AC_ROM_MR0_MIRR 0010001001001
#define AC_ROM_MR0 0010000110001
#define AC_ROM_MR1 0000001000100
#define AC_ROM_MR2 0000000010000
#define AC_ROM_MR3 0000000000000
#define AC_ROM_USER_ADD_0 0_0000_0000_0000
#define AC_ROM_USER_ADD_1 0_0000_0000_1000
#define AFI_CLK_FREQ 401
#define AFI_RATE_RATIO 1
#define AP_MODE 0
#define ARRIAVGZ 0
#define ARRIAV 0
#define AVL_CLK_FREQ 67
#define BFM_MODE 0
#define BURST2 0
#define CALIBRATE_BIT_SLIPS 0
#define CALIB_LFIFO_OFFSET 8
#define CALIB_VFIFO_OFFSET 6
#define CYCLONEV 1
#define DDR2 0
#define DDR3 1
#define DDRX 1
#define DM_PINS_ENABLED 1
#define ENABLE_ASSERT 0
#define ENABLE_BRINGUP_DEBUGGING 0
#define ENABLE_DELAY_CHAIN_WRITE 0
#define ENABLE_DQS_IN_CENTERING 1
#define ENABLE_DQS_OUT_CENTERING 0
#define ENABLE_EXPORT_SEQ_DEBUG_BRIDGE 0
#define ENABLE_INST_ROM_WRITE 1
#define ENABLE_MARGIN_REPORT_GEN 0
#define ENABLE_NON_DESTRUCTIVE_CALIB 0
#define ENABLE_NON_DES_CAL_TEST 0
#define ENABLE_NON_DES_CAL 0
#define ENABLE_SUPER_QUICK_CALIBRATION 0
#define ENABLE_TCL_DEBUG 0
#define FAKE_CAL_FAIL 0
#define FULL_RATE 1
#define GUARANTEED_READ_BRINGUP_TEST 0
#define HALF_RATE 0
#define HARD_PHY 1
#define HARD_VFIFO 1
#define HCX_COMPAT_MODE 0
#define HHP_HPS_SIMULATION 0
#define HHP_HPS_VERIFICATION 0
#define HHP_HPS 1
#define HPS_HW 1
#define HR_DDIO_OUT_HAS_THREE_REGS 0
#define IO_DELAY_PER_DCHAIN_TAP 25
#define IO_DELAY_PER_DQS_EN_DCHAIN_TAP 25
#define IO_DELAY_PER_OPA_TAP 312
#define IO_DLL_CHAIN_LENGTH 8
#define IO_DM_OUT_RESERVE 0
#define IO_DQDQS_OUT_PHASE_MAX 0
#define IO_DQS_EN_DELAY_MAX 31
#define IO_DQS_EN_DELAY_OFFSET 0
#define IO_DQS_EN_PHASE_MAX 7
#define IO_DQS_IN_DELAY_MAX 31
#define IO_DQS_IN_RESERVE 4
#define IO_DQS_OUT_RESERVE 4
#define IO_DQ_OUT_RESERVE 0
#define IO_IO_IN_DELAY_MAX 31
#define IO_IO_OUT1_DELAY_MAX 31
#define IO_IO_OUT2_DELAY_MAX 0
#define IO_SHIFT_DQS_EN_WHEN_SHIFT_DQS 0
#define LPDDR1 0
#define LPDDR2 0
#define LRDIMM 0
#define MARGIN_VARIATION_TEST 0
#define MAX_LATENCY_COUNT_WIDTH 5
#define MEM_ADDR_WIDTH 13
#define MRS_MIRROR_PING_PONG_ATSO 0
#define MULTIPLE_AFI_WLAT 0
#define NON_DES_CAL 0
#define NUM_SHADOW_REGS 1
#define QDRII 0
#define QUARTER_RATE 0
#define RDIMM 0
#define READ_AFTER_WRITE_CALIBRATION 1
#define READ_VALID_FIFO_SIZE 16
#define REG_FILE_INIT_SEQ_SIGNATURE 0x55550497
#define RLDRAM3 0
#define RLDRAMII 0
#define RLDRAMX 0
#define RUNTIME_CAL_REPORT 0
#define RW_MGR_MEM_ADDRESS_MIRRORING 0
#define RW_MGR_MEM_ADDRESS_WIDTH 15
#define RW_MGR_MEM_BANK_WIDTH 3
#define RW_MGR_MEM_CHIP_SELECT_WIDTH 1
#define RW_MGR_MEM_CLK_EN_WIDTH 1
#define RW_MGR_MEM_CONTROL_WIDTH 1
#define RW_MGR_MEM_DATA_MASK_WIDTH 4
#define RW_MGR_MEM_DATA_WIDTH 32
#define RW_MGR_MEM_DQ_PER_READ_DQS 8
#define RW_MGR_MEM_DQ_PER_WRITE_DQS 8
#define RW_MGR_MEM_IF_READ_DQS_WIDTH 4
#define RW_MGR_MEM_IF_WRITE_DQS_WIDTH 4
#define RW_MGR_MEM_NUMBER_OF_CS_PER_DIMM 1
#define RW_MGR_MEM_NUMBER_OF_RANKS 1
#define RW_MGR_MEM_ODT_WIDTH 1
#define RW_MGR_MEM_VIRTUAL_GROUPS_PER_READ_DQS 1
#define RW_MGR_MEM_VIRTUAL_GROUPS_PER_WRITE_DQS 1
#define RW_MGR_MR0_BL 1
#define RW_MGR_MR0_CAS_LATENCY 3
#define RW_MGR_TRUE_MEM_DATA_MASK_WIDTH 4
#define RW_MGR_WRITE_TO_DEBUG_READ 1.0
#define SKEW_CALIBRATION 0
#define SKIP_PTAP_0_DQS_EN_CAL 1
#define STATIC_FULL_CALIBRATION 1
#define STATIC_SIM_FILESET 0
#define STATIC_SKIP_MEM_INIT 0
#define STRATIXV 0
#define TINIT_CNTR1_VAL 32
#define TINIT_CNTR2_VAL 32
#define TINIT_CNTR0_VAL 99
#define TRACKING_ERROR_TEST 0
#define TRACKING_WATCH_TEST 0
#define TRESET_CNTR1_VAL 99
#define TRESET_CNTR2_VAL 10
#define TRESET_CNTR0_VAL 99
#define USE_DQS_TRACKING 1
#define USE_SHADOW_REGS 0
#define USE_USER_RDIMM_VALUE 0

#endif /* _SEQUENCER_DEFINES_H_ */
