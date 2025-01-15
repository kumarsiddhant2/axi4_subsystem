//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This file contains defines and typedefs to be compiled for use in
// the simulation running on the emulator when using Veloce.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
                                                                               

typedef enum bit[1:0] {WRITE_FIXED, WRITE_INCR, WRITE_WRAP,WRITE_RESERVED} awburst_e;
typedef enum bit[1:0] {READ_FIXED, READ_INCR, READ_WRAP,READ_RESERVED} arburst_e;
typedef enum bit[2:0] {WRITE_1_BYTE, WRITE_2_BYTE, WRITE_4_BYTE, WRITE_8_BYTE, WRITE_16_BYTE, WRITE_32_BYTE, WRITE_64_BYTE, WRITE_128_BYTE} awsize_e;
typedef enum bit[2:0] {READ_1_BYTE, READ_2_BYTE, READ_4_BYTE, READ_8_BYTE, READ_16_BYTE, READ_32_BYTE, READ_64_BYTE, READ_128_BYTE} arsize_e;
typedef enum bit {WRITE_NORMAL_ACCESS, WRITE_EXCLUSIVE_ACCESS} awlock_e;
typedef enum bit {READ_NORMAL_ACCESS, READ_EXCLUSIVE_ACCESS} arlock_e;
typedef enum bit[1:0] {WRITE_BUFFERABLE, WRITE_MODIFIABLE, WRITE_OTHER_ALLOCATE, WRITE_ALLOCATE} awcache_e;
typedef enum bit[1:0] {READ_BUFFERABLE, READ_MODIFIABLE, READ_OTHER_ALLOCATE, READ_ALLOCATE} arcache_e;
typedef enum bit {BIG_ENDIAN, LITTLE_ENDIAN} endian_e;
typedef enum bit[2:0] {WRITE_NORMAL_SECURE_DATA, WRITE_NORMAL_SECURE_INSTRUCTION, WRITE_NORMAL_NONSECURE_DATA, WRITE_NORMAL_NONSECURE_INSTRUCTION, WRITE_PRIVILEGED_SECURE_DATA, WRITE_PRIVILEGED_SECURE_INSTRUCTION, WRITE_PRIVILEGED_NONSECURE_DATA, WRITE_PRIVILEGED_NONSECURE_INSTRUCTION} awprot_e;
typedef enum bit[2:0] {READ_NORMAL_SECURE_DATA, READ_NORMAL_SECURE_INSTRUCTION, READ_NORMAL_NONSECURE_DATA, READ_NORMAL_NONSECURE_INSTRUCTION, READ_PRIVILEGED_SECURE_DATA, READ_PRIVILEGED_SECURE_INSTRUCTION, READ_PRIVILEGED_NONSECURE_DATA, READ_PRIVILEGED_NONSECURE_INSTRUCTION} arprot_e;
typedef enum bit[15:0] {AWID_0, AWID_1, AWID_2, AWID_3, AWID_4, AWID_5, AWID_6, AWID_7, AWID_8, AWID_9, AWID_10, AWID_11, AWID_12, AWID_13, AWID_14, AWID_15} awid_e;
typedef enum bit[15:0] {ARID_0, ARID_1, ARID_2, ARID_3, ARID_4, ARID_5, ARID_6, ARID_7, ARID_8, ARID_9, ARID_10, ARID_11, ARID_12, ARID_13, ARID_14, ARID_15} arid_e;
typedef enum bit[15:0] {BID_0, BID_1, BID_2, BID_3, BID_4, BID_5, BID_6, BID_7, BID_8, BID_9, BID_10, BID_11, BID_12, BID_13, BID_14, BID_15} bid_e;
typedef enum bit[15:0] {RID_0, RID_1, RID_2, RID_3, RID_4, RID_5, RID_6, RID_7, RID_8, RID_9, RID_10, RID_11, RID_12, RID_13, RID_14, RID_15} rid_e;
typedef enum bit[1:0] {WRITE_OKAY, WRITE_EXOKAY, WRITE_SLVERR, WRITE_DECERR} bresp_e;
typedef enum bit[1:0] {READ_OKAY, READ_EXOKAY, READ_SLVERR, READ_DECERR} rresp_e;
typedef enum bit {READ, WRITE} tx_type_e;
typedef enum bit[1:0] {BLOCKING_WRITE, BLOCKING_READ, NON_BLOCKING_WRITE, NON_BLOCKING_READ} transfer_type_e;
typedef enum bit[1:0] {RANDOM_DATA_MODE, SLAVE_MEM_MODE, USER_DATA_MODE, SLAVE_ERR_RESP_MODE} read_data_type_mode_e;
typedef enum bit[1:0] {ONLY_WRITE_DATA, ONLY_READ_DATA, WRITE_READ_DATA} write_read_data_mode_e;
typedef enum bit[1:0] {RESP_IN_ORDER, ONLY_READ_RESP_OUT_OF_ORDER, WRITE_READ_RESP_OUT_OF_ORDER, ONLY_WRITE_RESP_OUT_OF_ORDER} response_mode_e;
typedef enum bit[1:0] {QOS_MODE_DISABLE, ONLY_READ_QOS_MODE_ENABLE, WRITE_READ_QOS_MODE_ENABLE, ONLY_WRITE_QOS_MODE_ENABLE} qos_mode_e;
typedef struct {bit [3:0] awid; bit [31:0] awaddr; bit [7:0] awlen; bit [2:0] awsize; bit [1:0] awburst; bit awlock; bit [3:0] awcache; bit [3:0] awqos; bit [3:0] awregion; bit awuser; bit [2:0] awprot; bit awvalid; bit awready; bit [2**8:0][31:0] wdata; bit [2**8:0][3:0] wstrb; bit [2**8:0] wuser; bit wlast; bit [3:0] bid; bit [1:0] bresp; bit buser; bit bvalid; bit tx_type; int wait_count_write_address_channel; int wait_count_write_data_channel; int wait_count_write_response_channel; int outstanding_write_tx; int no_of_wait_states;} axi4_write_transfer_char_s;
typedef struct {bit [3:0] arid; bit [31:0] araddr; bit [7:0] arlen; bit [2:0] arsize; bit [1:0] arburst; bit [3:0] arcache; bit [2:0] arprot; bit [3:0] arqos; bit [3:0] arregion; bit [3:0] aruser; bit arlock; bit [3:0] rid; bit [2**8:0][31:0] rdata; bit [2**8:0][1:0] rresp; bit [2**8:0][3:0] ruser; bit rlast; bit rvalid; bit tx_type; int wait_count_read_address_channel; int wait_count_read_data_channel; int outstanding_read_tx; int no_of_wait_states;} axi4_read_transfer_char_s;
typedef struct {bit [31:0] min_address; bit [31:0] max_address; int wait_count_write_address_channel; int wait_count_write_data_channel; int wait_count_write_response_channel; int wait_count_read_address_channel; int wait_count_read_data_channel; int outstanding_write_tx; int outstanding_read_tx; response_mode_e slave_response_mode; qos_mode_e qos_mode_type;} axi4_transfer_cfg_s;

// pragma uvmf custom additional begin
// pragma uvmf custom additional end

