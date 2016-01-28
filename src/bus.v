/*BY LOMOT*/
`include "header/nettype.h.v"
`include "header/stddef.h.v"
	`define 	HIGH					1'b1
	`define		LOW						1'b0
	`define 	DISABLE					1'b0
	`define 	ENABLE					1'b1
	`define 	DISABLE_				1'b1
	`define 	ENABLE_					1'b0
	`define 	READ					1'b1
	`define 	WRITE					1'b0
	`define 	LSB						0
	`define 	BYTE_DATA_W				8
	`define 	BYTE_MSB				7
	`define 	ByteDataBus				7:0
	`define 	WORD_DATA_W				32
	`define 	WORD_MSB 				31
	`define 	WordDataBus				31:0
	`define 	WORD_ADDR_W 			30
	`define 	WORD_ADDR_MSB 			29
	`define 	WordAddrBus 			29:0
	`define 	BYTE_OFFSET_W 			2
	`define 	ByteOffsetBus 			1:0
	`define 	WordAddrLoc 			31:2
	`define 	ByteOffsetLoc 			1:0
	`define 	BYTE_OFFSET_WORD 		2'b00
`include "header/bus.h.v"
	`define		BUS_MASTER_CH					4
	`define		BUS_MASTER_INDEX_W				2
	`define		BUS_OWNER_MASTER_0				2'h0
	`define		BUS_OWNER_MASTER_1				2'h1
	`define		BUS_OWNER_MASTER_2				2'h2
	`define		BUS_OWNER_MASTER_3				2'h3
	`define		BUS_SLAVE_CH					8
	`define		BUS_SLAVE_INDEX_W				3

	`define		BUS_SLAVE_0						0
	`define		BUS_SLAVE_1						1
	`define		BUS_SLAVE_2						2
	`define		BUS_SLAVE_3						3
	`define		BUS_SLAVE_4						4
	`define		BUS_SLAVE_5						5
	`define		BUS_SLAVE_6						6
	`define		BUS_SLAVE_7						7

	`define		BusOwnerBus						1:0
	`define		BusSlaveIndexBus				2:0
	`define		BusSlaveIndexLoc				29:27
`include "header/global_config.h.v"
	/*BY LOMOT*/
		`ifdef POSITIVE_RESET
			`define		RESET_EDGE				posedge	
			`define		RESET_ENABLE			1'b1	
			`define		RESET_DISABLE			1'b0
		`endif

		`ifdef NEGEATIVE_RESET
			`define		RESET_EDGE				negedge	
			`define		RESET_ENABLE			1'b0	
			`define		RESET_DISABLE			1'b1
		`endif

		`ifdef POSITIVE_MEMORY
			`define		MEM_ENABLE				1'b1
			`define		MEM_DISABLE				1'b0
		`endif

		`ifdef NEGEATIVE_MEMORY
			`define		MEM_ENABLE				1'b0
			`define		MEM_DISABLE				1'b1
		`endif

		`ifdef IMPLEMENT_TIMER
			//
		`endif

		`ifdef IMPLEMENT_UART
			//
		`endif

		`ifdef IMPLEMENT_GPIO
			//
		`endif
`define  NEGEATIVE_RESET

module bus(
	clk,reset
	,m0_req_,m0_grnt_,m0_addr,m0_as_,m0_rw,m0_wr_data
	,m1_req_,m1_grnt_,m1_addr,m1_as_,m1_rw,m1_wr_data
	,m2_req_,m2_grnt_,m2_addr,m2_as_,m2_rw,m2_wr_data
	,m3_req_,m3_grnt_,m3_addr,m3_as_,m3_rw,m3_wr_data
	,m_rd_data,m_rdy_
	,s0_cs_,s0_rd_data,s0_rdy_
	,s1_cs_,s1_rd_data,s1_rdy_
	,s2_cs_,s2_rd_data,s2_rdy_
	,s3_cs_,s3_rd_data,s3_rdy_
	,s4_cs_,s4_rd_data,s4_rdy_
	,s5_cs_,s5_rd_data,s5_rdy_
	,s6_cs_,s6_rd_data,s6_rdy_
	,s7_cs_,s7_rd_data,s7_rdy_
	,s_addr,s_as_,s_rw,s_wr_data
	);

	//bus_arbiter.v
	input wire clk;
	input wire reset;

	input wire m0_req_;
	input wire m1_req_;
	input wire m2_req_;
	input wire m3_req_;

	output reg m0_grnt_;
	output reg m1_grnt_;
	output reg m2_grnt_;
	output reg m3_grnt_;

	//bus_master_mux.v
	input wire 	[`WordAddrBus] 	m0_addr;
	input wire 					m0_as_;
	input wire 					m0_rw;			
	input wire 	[`WordDataBus] 	m0_wr_data;

	input wire 	[`WordAddrBus] 	m1_addr;
	input wire 					m1_as_;
	input wire 					m1_rw;			
	input wire 	[`WordDataBus] 	m1_wr_data;

	input wire 	[`WordAddrBus] 	m2_addr;
	input wire 					m2_as_;
	input wire 					m2_rw;		
	input wire 	[`WordDataBus] 	m2_wr_data;

	input wire 	[`WordAddrBus] 	m3_addr;
	input wire 					m3_as_;
	input wire 					m3_rw;	
	input wire 	[`WordDataBus] 	m3_wr_data;

	output reg 	[`WordAddrBus]	s_addr;
	output reg  				s_as_;
	output reg 					s_rw;
	output reg  [`WordDataBus]	s_wr_data;

	//bus_slave_mux.v
	output wire s0_cs_;
	input wire [`WordDataBus] s0_rd_data;
	input wire s0_rdy_;

	output wire s1_cs_;
	input wire [`WordDataBus] s1_rd_data;
	input wire s1_rdy_;

	output wire s2_cs_;
	input wire [`WordDataBus] s2_rd_data;
	input wire s2_rdy_;

	output wire s3_cs_;
	input wire [`WordDataBus] s3_rd_data;
	input wire s3_rdy_;

	output wire s4_cs_;
	input wire [`WordDataBus] s4_rd_data;
	input wire s4_rdy_;

	output wire s5_cs_;
	input wire [`WordDataBus] s5_rd_data;
	input wire s5_rdy_;

	output wire s6_cs_;
	input wire [`WordDataBus] s6_rd_data;
	input wire s6_rdy_;

	output wire s7_cs_;
	input wire [`WordDataBus] s7_rd_data;
	input wire s7_rdy_;

	output reg [`WordDataBus] m_rd_data;
	output reg 					m_rdy_;

	bus_arbiter bus_arbiter_0();
	bus_master_mux bus_master_mux_0();
	bus_addr_dec bus_addr_d ec_0();
	bus_slave_mux bus_slave_mux_0();

endmodule