-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "11/03/2018 21:42:40"

-- 
-- Device: Altera 5CGXFC7C7F23C8 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	testbench IS
    PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	writedata : BUFFER std_logic_vector(31 DOWNTO 0);
	dataadr : BUFFER std_logic_vector(31 DOWNTO 0);
	certo : BUFFER std_logic
	);
END testbench;

-- Design Ports Information
-- writedata[0]	=>  Location: PIN_G15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[1]	=>  Location: PIN_H14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[2]	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[3]	=>  Location: PIN_P18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[4]	=>  Location: PIN_J22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[5]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[6]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[7]	=>  Location: PIN_K16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[8]	=>  Location: PIN_AA19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[9]	=>  Location: PIN_C16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[10]	=>  Location: PIN_J18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[11]	=>  Location: PIN_T13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[12]	=>  Location: PIN_P6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[13]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[14]	=>  Location: PIN_V9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[15]	=>  Location: PIN_H16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[16]	=>  Location: PIN_P14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[17]	=>  Location: PIN_H11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[18]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[19]	=>  Location: PIN_AB12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[20]	=>  Location: PIN_D17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[21]	=>  Location: PIN_G21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[22]	=>  Location: PIN_AA13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[23]	=>  Location: PIN_Y19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[24]	=>  Location: PIN_P19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[25]	=>  Location: PIN_T10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[26]	=>  Location: PIN_C21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[27]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[28]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[29]	=>  Location: PIN_P17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[30]	=>  Location: PIN_T18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writedata[31]	=>  Location: PIN_J8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[0]	=>  Location: PIN_T17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[1]	=>  Location: PIN_F20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[2]	=>  Location: PIN_AB6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[3]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[4]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[5]	=>  Location: PIN_F15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[6]	=>  Location: PIN_AA17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[7]	=>  Location: PIN_V19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[8]	=>  Location: PIN_AB11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[9]	=>  Location: PIN_R6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[10]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[11]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[12]	=>  Location: PIN_U21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[13]	=>  Location: PIN_B18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[14]	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[15]	=>  Location: PIN_R12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[16]	=>  Location: PIN_R15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[17]	=>  Location: PIN_U7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[18]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[19]	=>  Location: PIN_AB22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[20]	=>  Location: PIN_B20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[21]	=>  Location: PIN_AA14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[22]	=>  Location: PIN_D19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[23]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[24]	=>  Location: PIN_F19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[25]	=>  Location: PIN_U17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[26]	=>  Location: PIN_J9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[27]	=>  Location: PIN_Y17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[28]	=>  Location: PIN_P16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[29]	=>  Location: PIN_C19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[30]	=>  Location: PIN_E19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataadr[31]	=>  Location: PIN_U8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- certo	=>  Location: PIN_G22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_K20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_T12,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF testbench IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_writedata : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_dataadr : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_certo : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;

BEGIN

ww_clk <= clk;
ww_reset <= reset;
writedata <= ww_writedata;
dataadr <= ww_dataadr;
certo <= ww_certo;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X62_Y81_N36
\writedata[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(0));

-- Location: IOOBUF_X60_Y81_N2
\writedata[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(1));

-- Location: IOOBUF_X4_Y0_N2
\writedata[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(2));

-- Location: IOOBUF_X89_Y9_N56
\writedata[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(3));

-- Location: IOOBUF_X84_Y81_N19
\writedata[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(4));

-- Location: IOOBUF_X60_Y81_N36
\writedata[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(5));

-- Location: IOOBUF_X30_Y81_N2
\writedata[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(6));

-- Location: IOOBUF_X64_Y81_N53
\writedata[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(7));

-- Location: IOOBUF_X62_Y0_N53
\writedata[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(8));

-- Location: IOOBUF_X72_Y81_N53
\writedata[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(9));

-- Location: IOOBUF_X68_Y81_N53
\writedata[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(10));

-- Location: IOOBUF_X52_Y0_N2
\writedata[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(11));

-- Location: IOOBUF_X4_Y0_N19
\writedata[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(12));

-- Location: IOOBUF_X34_Y81_N76
\writedata[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(13));

-- Location: IOOBUF_X26_Y0_N59
\writedata[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(14));

-- Location: IOOBUF_X64_Y81_N2
\writedata[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(15));

-- Location: IOOBUF_X68_Y0_N19
\writedata[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(16));

-- Location: IOOBUF_X52_Y81_N2
\writedata[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(17));

-- Location: IOOBUF_X60_Y81_N53
\writedata[18]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(18));

-- Location: IOOBUF_X50_Y0_N76
\writedata[19]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(19));

-- Location: IOOBUF_X70_Y81_N2
\writedata[20]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(20));

-- Location: IOOBUF_X88_Y81_N20
\writedata[21]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(21));

-- Location: IOOBUF_X52_Y0_N36
\writedata[22]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(22));

-- Location: IOOBUF_X66_Y0_N42
\writedata[23]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(23));

-- Location: IOOBUF_X89_Y9_N39
\writedata[24]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(24));

-- Location: IOOBUF_X34_Y0_N59
\writedata[25]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(25));

-- Location: IOOBUF_X82_Y81_N42
\writedata[26]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(26));

-- Location: IOOBUF_X50_Y81_N76
\writedata[27]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(27));

-- Location: IOOBUF_X66_Y81_N42
\writedata[28]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(28));

-- Location: IOOBUF_X89_Y9_N22
\writedata[29]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(29));

-- Location: IOOBUF_X89_Y4_N45
\writedata[30]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(30));

-- Location: IOOBUF_X38_Y81_N19
\writedata[31]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_writedata(31));

-- Location: IOOBUF_X89_Y4_N62
\dataadr[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(0));

-- Location: IOOBUF_X76_Y81_N53
\dataadr[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(1));

-- Location: IOOBUF_X26_Y0_N93
\dataadr[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(2));

-- Location: IOOBUF_X32_Y81_N2
\dataadr[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(3));

-- Location: IOOBUF_X50_Y81_N93
\dataadr[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(4));

-- Location: IOOBUF_X66_Y81_N59
\dataadr[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(5));

-- Location: IOOBUF_X60_Y0_N53
\dataadr[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(6));

-- Location: IOOBUF_X70_Y0_N19
\dataadr[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(7));

-- Location: IOOBUF_X38_Y0_N36
\dataadr[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(8));

-- Location: IOOBUF_X2_Y0_N59
\dataadr[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(9));

-- Location: IOOBUF_X34_Y81_N42
\dataadr[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(10));

-- Location: IOOBUF_X89_Y38_N22
\dataadr[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(11));

-- Location: IOOBUF_X72_Y0_N53
\dataadr[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(12));

-- Location: IOOBUF_X84_Y81_N36
\dataadr[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(13));

-- Location: IOOBUF_X32_Y0_N19
\dataadr[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(14));

-- Location: IOOBUF_X36_Y0_N53
\dataadr[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(15));

-- Location: IOOBUF_X89_Y6_N22
\dataadr[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(16));

-- Location: IOOBUF_X2_Y0_N93
\dataadr[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(17));

-- Location: IOOBUF_X36_Y81_N36
\dataadr[18]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(18));

-- Location: IOOBUF_X64_Y0_N53
\dataadr[19]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(19));

-- Location: IOOBUF_X86_Y81_N53
\dataadr[20]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(20));

-- Location: IOOBUF_X52_Y0_N53
\dataadr[21]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(21));

-- Location: IOOBUF_X86_Y81_N19
\dataadr[22]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(22));

-- Location: IOOBUF_X36_Y81_N53
\dataadr[23]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(23));

-- Location: IOOBUF_X76_Y81_N2
\dataadr[24]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(24));

-- Location: IOOBUF_X72_Y0_N2
\dataadr[25]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(25));

-- Location: IOOBUF_X36_Y81_N2
\dataadr[26]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(26));

-- Location: IOOBUF_X58_Y0_N42
\dataadr[27]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(27));

-- Location: IOOBUF_X89_Y9_N5
\dataadr[28]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(28));

-- Location: IOOBUF_X78_Y81_N2
\dataadr[29]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(29));

-- Location: IOOBUF_X86_Y81_N2
\dataadr[30]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(30));

-- Location: IOOBUF_X2_Y0_N76
\dataadr[31]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_dataadr(31));

-- Location: IOOBUF_X82_Y81_N76
\certo~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_certo);

-- Location: IOIBUF_X72_Y81_N1
\reset~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: IOIBUF_X52_Y0_N18
\clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: LABCELL_X9_Y47_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


