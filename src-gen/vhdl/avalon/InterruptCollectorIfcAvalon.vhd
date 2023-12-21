-- Copyright (C) 2023 Eccelerators GmbH
-- 
-- This code was generated by:
--
-- HxS Compiler 1.0.19-10671667
-- VHDL Extension for HxS 1.0.21-b962bd24
-- 
-- Further information at https://eccelerators.com/hxs
-- 
-- Changes to this file may cause incorrect behavior and will be lost if the
-- code is regenerated.
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

use work.InterruptCollectorIfcPackage.all;

entity InterruptCollectorBlk_InterruptCollectorIfc is
	port (
		Clk : in std_logic;
		Rst : in std_logic;
		Address : in std_logic_vector(3 downto 0);
		ByteEnable : in std_logic_vector(3 downto 0);
		Read : in std_logic;
		ReadData : out std_logic_vector(31 downto 0);
		Write : in std_logic;
		WriteData : in std_logic_vector(31 downto 0);
		WaitRequest : out std_logic;
		Match : out std_logic;
		Mask3 : out std_logic;
		Mask2 : out std_logic;
		Mask1 : out std_logic;
		Mask0 : out std_logic;
		Request3ToBeRead : in std_logic;
		Request3Written : out std_logic;
		Request2ToBeRead : in std_logic;
		Request2Written : out std_logic;
		Request1ToBeRead : in std_logic;
		Request1Written : out std_logic;
		Request0ToBeRead : in std_logic;
		Request0Written : out std_logic;
		WTransPulseInterruptRequestReg : out std_logic;
		Service3ToBeRead : in std_logic;
		Service3Written : out std_logic;
		Service2ToBeRead : in std_logic;
		Service2Written : out std_logic;
		Service1ToBeRead : in std_logic;
		Service1Written : out std_logic;
		Service0ToBeRead : in std_logic;
		Service0Written : out std_logic;
		WTransPulseInterruptServiceReg : out std_logic
	);
end;

architecture Behavioural of InterruptCollectorBlk_InterruptCollectorIfc is

	signal PreReadData : std_logic_vector(31 downto 0);
	
	signal PreReadDataInterruptMaskReg : std_logic_vector(31 downto 0);
	signal PreReadAckInterruptMaskReg : std_logic;
	signal ReadDiffInterruptMaskReg : std_logic;
	signal PreWriteAckInterruptMaskReg : std_logic;
	signal WriteDiffInterruptMaskReg : std_logic;
	signal WRegMask3 : std_logic;
	signal WRegMask2 : std_logic;
	signal WRegMask1 : std_logic;
	signal WRegMask0 : std_logic;
	signal PreMatchReadInterruptMaskReg : std_logic;
	signal PreMatchWriteInterruptMaskReg : std_logic;
	
	signal PreReadDataInterruptRequestReg : std_logic_vector(31 downto 0);
	signal PreReadAckInterruptRequestReg : std_logic;
	signal ReadDiffInterruptRequestReg : std_logic;
	signal PreWriteAckInterruptRequestReg : std_logic;
	signal WriteDiffInterruptRequestReg : std_logic;
	signal PreMatchReadInterruptRequestReg : std_logic;
	signal PreMatchWriteInterruptRequestReg : std_logic;
	
	signal PreReadDataInterruptServiceReg : std_logic_vector(31 downto 0);
	signal PreReadAckInterruptServiceReg : std_logic;
	signal ReadDiffInterruptServiceReg : std_logic;
	signal PreWriteAckInterruptServiceReg : std_logic;
	signal WriteDiffInterruptServiceReg : std_logic;
	signal PreMatchReadInterruptServiceReg : std_logic;
	signal PreMatchWriteInterruptServiceReg : std_logic;

begin

	ReadData <= PreReadData;
	
	Match <= PreMatchReadInterruptMaskReg or PreMatchWriteInterruptMaskReg
		  or PreMatchReadInterruptRequestReg or PreMatchWriteInterruptRequestReg
		  or PreMatchReadInterruptServiceReg or PreMatchWriteInterruptServiceReg;
	
	WaitRequest <= not (PreReadAckInterruptMaskReg or PreWriteAckInterruptMaskReg
		or PreReadAckInterruptRequestReg or PreWriteAckInterruptRequestReg
		or PreReadAckInterruptServiceReg or PreWriteAckInterruptServiceReg);
	
	PreDatOutMux: process (
		PreReadDataInterruptMaskReg,
		PreMatchReadInterruptMaskReg,
		PreReadAckInterruptMaskReg,
		PreReadDataInterruptRequestReg,
		PreMatchReadInterruptRequestReg,
		PreReadAckInterruptRequestReg,
		PreReadDataInterruptServiceReg,
		PreMatchReadInterruptServiceReg,
		PreReadAckInterruptServiceReg
	) begin
		PreReadData <= (others => '0');
		if (PreMatchReadInterruptMaskReg = '1' and PreReadAckInterruptMaskReg = '1') then
			PreReadData <= std_logic_vector(resize(unsigned(PreReadDataInterruptMaskReg), PreReadData'LENGTH));
		elsif (PreMatchReadInterruptRequestReg = '1' and PreReadAckInterruptRequestReg = '1') then
			PreReadData <= std_logic_vector(resize(unsigned(PreReadDataInterruptRequestReg), PreReadData'LENGTH));
		elsif (PreMatchReadInterruptServiceReg = '1' and PreReadAckInterruptServiceReg = '1') then
			PreReadData <= std_logic_vector(resize(unsigned(PreReadDataInterruptServiceReg), PreReadData'LENGTH));
		end if;
	end process;
	
	PreMatchReadInterruptMaskRegProcess : process (Address, Read)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTMASKREG_ADDRESS)) then
			PreMatchReadInterruptMaskReg <= Read;
		else
			PreMatchReadInterruptMaskReg <= '0';
		end if;
	end process;
	
	PreMatchWriteInterruptMaskRegProcess : process (Address, Write)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTMASKREG_ADDRESS)) then
			PreMatchWriteInterruptMaskReg <= Write;
		else
			PreMatchWriteInterruptMaskReg <= '0';
		end if;
	end process;
	
	WriteDiffInterruptMaskRegProcess : process (Address, Write, PreWriteAckInterruptMaskReg)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTMASKREG_ADDRESS)) then
			WriteDiffInterruptMaskReg <=  Write and not PreWriteAckInterruptMaskReg;
		else
			WriteDiffInterruptMaskReg <= '0';
		end if;
	end process;
	
	ReadDiffInterruptMaskRegProcess : process (Address, Read, PreReadAckInterruptMaskReg)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTMASKREG_ADDRESS)) then
			ReadDiffInterruptMaskReg <= Read and not PreReadAckInterruptMaskReg;
		else
			ReadDiffInterruptMaskReg <= '0';
		end if;
	end process;
	
	SyncPartInterruptMaskReg : process (Clk, Rst)
	begin
		if (Rst = '1') then
			PreReadAckInterruptMaskReg <= '0';
			PreWriteAckInterruptMaskReg <= '0';
			WRegMask3 <= MASK3_INTERRUPTDISABLED;
			WRegMask2 <= MASK2_INTERRUPTDISABLED;
			WRegMask1 <= MASK1_INTERRUPTDISABLED;
			WRegMask0 <= MASK0_INTERRUPTDISABLED;
		elsif rising_edge(Clk) then
			PreWriteAckInterruptMaskReg <= WriteDiffInterruptMaskReg;
			PreReadAckInterruptMaskReg <= ReadDiffInterruptMaskReg;
			if (WriteDiffInterruptMaskReg = '1') then
				if (ByteEnable(0) = '1') then WRegMask0 <= WriteData(0); end if;
				if (ByteEnable(0) = '1') then WRegMask1 <= WriteData(1); end if;
				if (ByteEnable(0) = '1') then WRegMask2 <= WriteData(2); end if;
				if (ByteEnable(0) = '1') then WRegMask3 <= WriteData(3); end if;
			end if;
		end if;
	end process;
	
	DataOutPreMuxForInterruptMaskReg : process (
		WRegMask3,
		WRegMask2,
		WRegMask1,
		WRegMask0
	) begin
		PreReadDataInterruptMaskReg <= (others => '0');
		PreReadDataInterruptMaskReg(3) <= WRegMask3;
		PreReadDataInterruptMaskReg(2) <= WRegMask2;
		PreReadDataInterruptMaskReg(1) <= WRegMask1;
		PreReadDataInterruptMaskReg(0) <= WRegMask0;
	end process;
	
	Mask3 <= WRegMask3;
	Mask2 <= WRegMask2;
	Mask1 <= WRegMask1;
	Mask0 <= WRegMask0;
	
	PreMatchReadInterruptRequestRegProcess : process (Address, Read)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTREQUESTREG_ADDRESS)) then
			PreMatchReadInterruptRequestReg <= Read;
		else
			PreMatchReadInterruptRequestReg <= '0';
		end if;
	end process;
	
	PreMatchWriteInterruptRequestRegProcess : process (Address, Write)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTREQUESTREG_ADDRESS)) then
			PreMatchWriteInterruptRequestReg <= Write;
		else
			PreMatchWriteInterruptRequestReg <= '0';
		end if;
	end process;
	
	WriteDiffInterruptRequestRegProcess : process (Address, Write, PreWriteAckInterruptRequestReg)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTREQUESTREG_ADDRESS)) then
			WriteDiffInterruptRequestReg <=  Write and not PreWriteAckInterruptRequestReg;
		else
			WriteDiffInterruptRequestReg <= '0';
		end if;
	end process;
	
	ReadDiffInterruptRequestRegProcess : process (Address, Read, PreReadAckInterruptRequestReg)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTREQUESTREG_ADDRESS)) then
			ReadDiffInterruptRequestReg <= Read and not PreReadAckInterruptRequestReg;
		else
			ReadDiffInterruptRequestReg <= '0';
		end if;
	end process;
	
	SyncPartInterruptRequestReg : process (Clk, Rst)
	begin
		if (Rst = '1') then
			PreReadAckInterruptRequestReg <= '0';
			PreWriteAckInterruptRequestReg <= '0';
		elsif rising_edge(Clk) then
			PreWriteAckInterruptRequestReg <= WriteDiffInterruptRequestReg;
			PreReadAckInterruptRequestReg <= ReadDiffInterruptRequestReg;
		end if;
	end process;
	
	DataOutPreMuxForInterruptRequestReg : process (
		Request3ToBeRead,
		Request2ToBeRead,
		Request1ToBeRead,
		Request0ToBeRead
	) begin
		PreReadDataInterruptRequestReg <= (others => '0');
		PreReadDataInterruptRequestReg(3) <= Request3ToBeRead;
		PreReadDataInterruptRequestReg(2) <= Request2ToBeRead;
		PreReadDataInterruptRequestReg(1) <= Request1ToBeRead;
		PreReadDataInterruptRequestReg(0) <= Request0ToBeRead;
	end process;
	
	WTransPulseInterruptRequestReg <= WriteDiffInterruptRequestReg;
	
	Request3Written <= WriteData(3);
	Request2Written <= WriteData(2);
	Request1Written <= WriteData(1);
	Request0Written <= WriteData(0);
	
	PreMatchReadInterruptServiceRegProcess : process (Address, Read)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTSERVICEREG_ADDRESS)) then
			PreMatchReadInterruptServiceReg <= Read;
		else
			PreMatchReadInterruptServiceReg <= '0';
		end if;
	end process;
	
	PreMatchWriteInterruptServiceRegProcess : process (Address, Write)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTSERVICEREG_ADDRESS)) then
			PreMatchWriteInterruptServiceReg <= Write;
		else
			PreMatchWriteInterruptServiceReg <= '0';
		end if;
	end process;
	
	WriteDiffInterruptServiceRegProcess : process (Address, Write, PreWriteAckInterruptServiceReg)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTSERVICEREG_ADDRESS)) then
			WriteDiffInterruptServiceReg <=  Write and not PreWriteAckInterruptServiceReg;
		else
			WriteDiffInterruptServiceReg <= '0';
		end if;
	end process;
	
	ReadDiffInterruptServiceRegProcess : process (Address, Read, PreReadAckInterruptServiceReg)
	begin
		if ((unsigned(Address)/4)*4 = unsigned(INTERRUPTSERVICEREG_ADDRESS)) then
			ReadDiffInterruptServiceReg <= Read and not PreReadAckInterruptServiceReg;
		else
			ReadDiffInterruptServiceReg <= '0';
		end if;
	end process;
	
	SyncPartInterruptServiceReg : process (Clk, Rst)
	begin
		if (Rst = '1') then
			PreReadAckInterruptServiceReg <= '0';
			PreWriteAckInterruptServiceReg <= '0';
		elsif rising_edge(Clk) then
			PreWriteAckInterruptServiceReg <= WriteDiffInterruptServiceReg;
			PreReadAckInterruptServiceReg <= ReadDiffInterruptServiceReg;
		end if;
	end process;
	
	DataOutPreMuxForInterruptServiceReg : process (
		Service3ToBeRead,
		Service2ToBeRead,
		Service1ToBeRead,
		Service0ToBeRead
	) begin
		PreReadDataInterruptServiceReg <= (others => '0');
		PreReadDataInterruptServiceReg(3) <= Service3ToBeRead;
		PreReadDataInterruptServiceReg(2) <= Service2ToBeRead;
		PreReadDataInterruptServiceReg(1) <= Service1ToBeRead;
		PreReadDataInterruptServiceReg(0) <= Service0ToBeRead;
	end process;
	
	WTransPulseInterruptServiceReg <= WriteDiffInterruptServiceReg;
	
	Service3Written <= WriteData(3);
	Service2Written <= WriteData(2);
	Service1Written <= WriteData(1);
	Service0Written <= WriteData(0);
	
end;

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity InterruptCollectorIfcBusMonitor is
	port (
		Clk : in std_logic;
		Rst : in std_logic;
		Read : in  std_logic;
		Write : in  std_logic;
		Match : in std_logic;
		UnoccupiedAck : out std_logic;
		TimeoutAck : out std_logic
	);
end;

architecture Behavioural of InterruptCollectorIfcBusMonitor is

	signal BusAccessDelay : std_logic;
	signal BusAccess : std_logic;
	signal PreUnoccupiedAck : std_logic;
	signal PreTimeoutAck : std_logic;
	signal TimeoutCounter : unsigned(9 downto 0);

begin

	BusAccess <= Read or Write;

	BusAccessDetection : process (Clk, Rst)
	begin
		if (Rst = '1') then
			BusAccessDelay <= '0';
		elsif rising_edge(Clk) then
			BusAccessDelay <= BusAccess;
		end if;
	end process;

	MatchDetection : process (Clk, Rst)
	begin
		if (Rst = '1') then
			PreUnoccupiedAck <= '0';
		elsif rising_edge(Clk) then
			PreUnoccupiedAck <= '0';
			if ((BusAccess = '1') and (BusAccessDelay = '1') and (Match = '0')) then
				PreUnoccupiedAck <= not PreUnoccupiedAck;
			end if;
		end if;
	end process;
	
	TimeoutDetection : process (Clk, Rst)
	begin
		if (Rst = '1') then
			PreTimeoutAck <= '0';
			TimeoutCounter <= (others => '1');
		elsif rising_edge(Clk) then
			PreTimeoutAck <= '0';
			TimeoutCounter <= (others => '1');
			if ((BusAccess = '1') and (BusAccessDelay = '1') and (Match = '1')) then
				if (TimeoutCounter = 0) then
					PreTimeoutAck <= not PreTimeoutAck;
				else
					TimeoutCounter <= TimeoutCounter - 1;
				end if;
			end if;
		end if;
	end process;

	UnoccupiedAck <= PreUnoccupiedAck;
	TimeoutAck <= PreTimeoutAck;
	
end;

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

use work.InterruptCollectorIfcPackage.all;

entity InterruptCollectorIfcAvalon is
	port (
		Clk : in std_logic;
		Rst : in std_logic;
		AvalonDown : in T_InterruptCollectorIfcAvalonDown;
		AvalonUp : out T_InterruptCollectorIfcAvalonUp;
		Trace : out T_InterruptCollectorIfcTrace;
		InterruptCollectorBlkDown : out T_InterruptCollectorIfcInterruptCollectorBlkDown;
		InterruptCollectorBlkUp : in T_InterruptCollectorIfcInterruptCollectorBlkUp
	);
end;

architecture Behavioural of InterruptCollectorIfcAvalon is

	signal BlockMatch : std_logic;
	signal UnoccupiedAck : std_logic;
	signal TimeoutAck : std_logic;
	
	signal PreAvalonUp : T_InterruptCollectorIfcAvalonUp;
	
	signal InterruptCollectorBlkReadData : std_logic_vector(31 downto 0);
	signal InterruptCollectorBlkWaitRequest : std_logic;
	signal InterruptCollectorBlkMatch : std_logic;

begin

	i_InterruptCollectorIfcBusMonitor : entity work.InterruptCollectorIfcBusMonitor
		port map (
			Clk => Clk,
			Rst => Rst,
			Read => AvalonDown.Read,
			Write => AvalonDown.Write,
			Match => BlockMatch,
			UnoccupiedAck => UnoccupiedAck,
			TimeoutAck => TimeoutAck
		);
	
	i_InterruptCollectorBlk_InterruptCollectorIfc : entity work.InterruptCollectorBlk_InterruptCollectorIfc
		port map (
			Clk => Clk,
			Rst => Rst,
			Address => AvalonDown.Address,
			ByteEnable => AvalonDown.ByteEnable,
			Read => AvalonDown.Read,
			ReadData =>  InterruptCollectorBlkReadData,
			Write => AvalonDown.Write,
			WriteData => AvalonDown.WriteData,
			WaitRequest => InterruptCollectorBlkWaitRequest,
			Match => InterruptCollectorBlkMatch,
			Mask3 => InterruptCollectorBlkDown.Mask3,
			Mask2 => InterruptCollectorBlkDown.Mask2,
			Mask1 => InterruptCollectorBlkDown.Mask1,
			Mask0 => InterruptCollectorBlkDown.Mask0,
			Request3ToBeRead => InterruptCollectorBlkUp.Request3ToBeRead,
			Request3Written => InterruptCollectorBlkDown.Request3Written,
			Request2ToBeRead => InterruptCollectorBlkUp.Request2ToBeRead,
			Request2Written => InterruptCollectorBlkDown.Request2Written,
			Request1ToBeRead => InterruptCollectorBlkUp.Request1ToBeRead,
			Request1Written => InterruptCollectorBlkDown.Request1Written,
			Request0ToBeRead => InterruptCollectorBlkUp.Request0ToBeRead,
			Request0Written => InterruptCollectorBlkDown.Request0Written,
			WTransPulseInterruptRequestReg => InterruptCollectorBlkDown.WTransPulseInterruptRequestReg,
			Service3ToBeRead => InterruptCollectorBlkUp.Service3ToBeRead,
			Service3Written => InterruptCollectorBlkDown.Service3Written,
			Service2ToBeRead => InterruptCollectorBlkUp.Service2ToBeRead,
			Service2Written => InterruptCollectorBlkDown.Service2Written,
			Service1ToBeRead => InterruptCollectorBlkUp.Service1ToBeRead,
			Service1Written => InterruptCollectorBlkDown.Service1Written,
			Service0ToBeRead => InterruptCollectorBlkUp.Service0ToBeRead,
			Service0Written => InterruptCollectorBlkDown.Service0Written,
			WTransPulseInterruptServiceReg => InterruptCollectorBlkDown.WTransPulseInterruptServiceReg
		);
	
	Trace.AvalonDown <= AvalonDown;
	Trace.AvalonUp <= PreAvalonUp;
	Trace.UnoccupiedAck <= UnoccupiedAck;
	Trace.TimeoutAck <= TimeoutAck;
	
	AvalonUp <= PreAvalonUp;
	
	PreAvalonUp.ReadData <= InterruptCollectorBlkReadData;
	
	PreAvalonUp.WaitRequest <= InterruptCollectorBlkWaitRequest
		and not UnoccupiedAck
		and not TimeoutAck;
	
	BlockMatch <= InterruptCollectorBlkMatch;

end;