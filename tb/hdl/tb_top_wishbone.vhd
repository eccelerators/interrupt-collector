-- ******************************************************************************
-- 
--                   /------o
--             eccelerators
--          o------/
-- 
--  This file is an Eccelerators GmbH sample project.
-- 
--  MIT License:
--  Copyright (c) 2023 Eccelerators GmbH
-- 
--  Permission is hereby granted, free of charge, to any person obtaining a copy
--  of this software and associated documentation files (the "Software"), to deal
--  in the Software without restriction, including without limitation the rights
--  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  copies of the Software, and to permit persons to whom the Software is
--  furnished to do so, subject to the following conditions:
-- 
--  The above copyright notice and this permission notice shall be included in all
--  copies or substantial portions of the Software.
-- 
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--  SOFTWARE.
-- ******************************************************************************
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    

use work.basic.all;    
use work.InterruptCollectorIfcPackage.all;
use work.tb_bus_pkg.all;
use work.tb_signals_pkg.all;
use work.tb_base_pkg.all;
use work.InterruptGeneratorIfcPackage.all;
use work.BusDividerIfcPackage.all;

entity tb_top_wishbone is
    generic (
        stimulus_path : string := "tb/simstm/";
        stimulus_file : string := "testMain.stm";
        stimulus_main_entry_label : in string := "$testMain";
        stimulus_test_suite_index : integer := 255
    );
end;

architecture behavioural of tb_top_wishbone is

    signal simdone : std_logic := '0';
    
    signal Clk : std_logic := '0';
    signal Rst : std_logic := '1';
    signal TimeoutAck_Detected : std_logic := '0';
    signal TimeoutAck_Rec_Clear : std_logic := '0';
    
    signal executing_line0 : integer := 0;
    signal executing_file0 : text_line;
    signal marker0 : std_logic_vector(15 downto 0) := (others => '0');
    signal standard_test_error_count0 : std_logic_vector(31 downto 0);
    signal standard_test_error_count1 : std_logic_vector(31 downto 0);
    
    signal signals_in0 : t_signals_in;
    signal signals_out0 : t_signals_out;

    signal bus_down0 : t_bus_down;
    signal bus_up0 : t_bus_up;
    
    signal executing_line1 : integer := 0;
    signal executing_file1 : text_line;
    signal marker1 : std_logic_vector(15 downto 0) := (others => '0');
    
    signal signals_in1 : t_signals_in;
    signal signals_out1 : t_signals_out;

    signal bus_down1 : t_bus_down;
    signal bus_up1 : t_bus_up;        
    
    signal InterruptToDispatch : std_logic;
    signal InterruptsBusyFromCpus : std_logic_vector(1 downto 0);
    signal InterruptsEnableFromCpus : std_logic_vector(1 downto 0);
    signal InterruptsToCpus : std_logic_vector(1 downto 0);
    
    signal InterruptCollectorIfcWishboneDown : T_InterruptCollectorIfcWishboneDown;
    signal InterruptCollectorIfcWishboneUp : T_InterruptCollectorIfcWishboneUp;    
    
    signal InterruptCollectorIfcInterruptCollectorBlkDown :T_InterruptCollectorIfcInterruptCollectorBlkDown;
    signal InterruptCollectorIfcInterruptCollectorBlkUp : T_InterruptCollectorIfcInterruptCollectorBlkUp;
    signal InterruptCollectorIfcTrace : T_InterruptCollectorIfcTrace;
        
    signal InterruptGeneratorIfcWishboneDown : T_InterruptGeneratorIfcWishboneDown;
    signal InterruptGeneratorIfcWishboneUp : T_InterruptGeneratorIfcWishboneUp;
    signal InterruptGeneratorIfcTrace : T_InterruptGeneratorIfcTrace;
    signal InterruptGeneratorIfcInterruptGeneratorBlkDown : T_InterruptGeneratorIfcInterruptGeneratorBlkDown;
    signal InterruptGeneratorIfcInterruptGeneratorBlkUp : T_InterruptGeneratorIfcInterruptGeneratorBlkUp;
    
    signal BusDividerIfcWishboneDown : T_BusDividerIfcWishboneDown;
    signal BusDividerIfcWishboneUp : T_BusDividerIfcWishboneUp;  
    signal BusDividerIfcTrace : T_BusDividerIfcTrace;  
    signal BusDividerIfcBusDividerBlkDown : T_BusDividerIfcBusDividerBlkDown;  
    signal BusDividerIfcBusDividerBlkUp : T_BusDividerIfcBusDividerBlkUp;   
    
    signal Cyc : std_logic_vector(1 downto 0);
    signal Adr : array_of_std_logic_vector(1 downto 0)(31 downto 0);
    signal Sel : array_of_std_logic_vector(1 downto 0)(3 downto 0);
    signal We : std_logic_vector(1 downto 0);
    signal Stb : std_logic_vector(1 downto 0);
    signal DatIn : array_of_std_logic_vector(1 downto 0)(31 downto 0);
    signal DatOut : array_of_std_logic_vector(1 downto 0)(31 downto 0);
    signal Ack : std_logic_vector(1 downto 0); 
    
    signal JoinCyc : std_logic;
    signal JoinAdr : std_logic_vector(31 downto 0);
    signal JoinSel : std_logic_vector(3 downto 0);
    signal JoinWe : std_logic;
    signal JoinStb : std_logic;
    signal JoinDatOut : std_logic_vector(31 downto 0);
    signal JoinDatIn: std_logic_vector(31 downto 0);
    signal JoinAck : std_logic;
    
    signal GeneratedInterrupt : std_logic_vector(3 downto 0);
    signal GeneratorFailure : std_logic;
    
    signal ChannelOperation : std_logic_vector(3 downto 0);
    signal ChannelStatus : array_of_std_logic_vector(3 downto 0)(1 downto 0);
    signal ChargedCount : array_of_std_logic_vector(3 downto 0)(31 downto 0);
    signal ActualCount : array_of_std_logic_vector(3 downto 0)(31 downto 0);
    signal FailureCount : array_of_std_logic_vector(3 downto 0)(31 downto 0);
    signal Interval : array_of_std_logic_vector(3 downto 0)(31 downto 0);
    signal ReferenceCount : array_of_std_logic_vector(3 downto 0)(31 downto 0);
    signal WRegPulseReferenceCount: std_logic_vector(3 downto 0);
    
    signal Mask : std_logic_vector(3 downto 0);
    signal RequestWritten : std_logic_vector(3 downto 0);
    signal ServiceWritten : std_logic_vector(3 downto 0);
    signal RequestToBeRead : std_logic_vector(3 downto 0);
    signal ServiceToBeRead : std_logic_vector(3 downto 0);
    
begin

    Rst <= transport '0' after 100 ns;
    Clk <= transport (not Clk) and (not SimDone)  after 10 ns / 2; -- 100MHz

    signals_in0.in_signal_1000 <= InterruptsToCpus(0);
    signals_in0.in_signal_1010 <= signals_out1.out_signal_3001; -- cross core notify interrupt from/to other core
  
    signals_in0.in_signal_2000 <= GeneratorFailure;
    signals_in0.in_signal_2001 <= x"00"; -- core number hard coded 
    signals_in0.in_signal_2002 <= signals_out1.out_signal_3000; -- cross core sync signal in from other core
    signals_in0.in_signal_2003 <= signals_out1.out_signal_3002; -- cross core notify interrupt is in service from/to other core

    InterruptsBusyFromCpus(0) <= signals_out0.out_signal_1001;
    InterruptsEnableFromCpus(0) <= signals_out0.out_signal_1002;
   
    
    signals_in1.in_signal_1000 <= InterruptsToCpus(1);
    signals_in1.in_signal_1010 <= signals_out0.out_signal_3001; -- cross core notify interrupt from/to other core
     
    signals_in1.in_signal_2000 <= GeneratorFailure;
    signals_in1.in_signal_2001 <= x"01"; -- core number hard coded 
    signals_in1.in_signal_2002 <= signals_out0.out_signal_3000;
    signals_in1.in_signal_2003 <= signals_out0.out_signal_3002; -- cross core notify interrupt is in service from/to other core
        
    InterruptsBusyFromCpus(1) <= signals_out0.out_signal_1011;
    InterruptsEnableFromCpus(1) <= signals_out0.out_signal_1012;    
    
   
    i0_tb_simstm : entity work.tb_simstm
        generic map (
            stimulus_path => stimulus_path,
            stimulus_file => stimulus_file          
        )
        port map (
            clk => Clk,
            rst => Rst,
            simdone => SimDone,       
            executing_line => executing_line0,
            executing_file => executing_file0,
            standard_test_error_count => standard_test_error_count0,
            marker => marker0,
            signals_in => signals_in0,
            signals_out => signals_out0,
            bus_down => bus_down0,
            bus_up => bus_up0
        );
        
    i1_tb_simstm : entity work.tb_simstm
        generic map (
            stimulus_path => stimulus_path,
            stimulus_file => stimulus_file          
        )
        port map (
            clk => Clk,
            rst => Rst,
            simdone => open,       
            executing_line => executing_line1,
            executing_file => executing_file1,
            standard_test_error_count => standard_test_error_count1,
            marker => marker1,
            signals_in => signals_in1,
            signals_out => signals_out1,
            bus_down => bus_down1,
            bus_up => bus_up1
        );
        
        
    i_InterruptDispatcher : entity work.InterruptDispatcher
        generic map(
            NUMBER_OF_OUTPUTS => 2
        )
        port map(
            Clk => Clk,
            Rst => Rst,
            InterruptInToDispatch => InterruptToDispatch,
            InterruptsBusyFromCpus => InterruptsBusyFromCpus,
            InterruptsEnableFromCpus => InterruptsEnableFromCpus,
            InterruptsOutToCpus => InterruptsToCpus
        );

        
    Cyc(1) <= bus_down1.wishbone.cyc;
    Cyc(0) <= bus_down0.wishbone.cyc;
    Adr(1) <= bus_down1.wishbone.adr;
    Adr(0) <= bus_down0.wishbone.adr;
    Sel(1) <= bus_down1.wishbone.sel;
    Sel(0) <= bus_down0.wishbone.sel;
    We(1) <= bus_down1.wishbone.we;
    We(0) <= bus_down0.wishbone.we;
    Stb(1) <= bus_down1.wishbone.stb;
    Stb(0) <= bus_down0.wishbone.stb;
    DatIn(1) <= bus_down1.wishbone.data;
    DatIn(0) <= bus_down0.wishbone.data;
    bus_up1.wishbone.data <= DatOut(1);
    bus_up0.wishbone.data <= DatOut(0);
    bus_up1.wishbone.ack <= Ack(1);
    bus_up0.wishbone.ack <= Ack(0);
        
    i_BusJoinWishbone : entity work.BusJoinWishbone
        port map (
            Clk => Clk,
            Rst => Rst,
            Cyc => Cyc,
            Adr => Adr,
            Sel => Sel,
            We => We,
            Stb => Stb,
            DatIn => DatIn,
            DatOut => DatOut,
            Ack => Ack,
            JoinCyc => JoinCyc,
            JoinAdr => JoinAdr,
            JoinSel => JoinSel,
            JoinWe => JoinWe,
            JoinStb => JoinStb,
            JoinDatOut => JoinDatOut,
            JoinDatIn => JoinDatIn,
            JoinAck => JoinAck
        );

    BusDividerIfcWishboneDown.Cyc <= JoinCyc;
    BusDividerIfcWishboneDown.Adr <= JoinAdr(8 downto 0);
    BusDividerIfcWishboneDown.Sel <= JoinSel;
    BusDividerIfcWishboneDown.We <= JoinWe;
    BusDividerIfcWishboneDown.Stb <= JoinStb;
    BusDividerIfcWishboneDown.DatIn <= JoinDatOut; 
    
    JoinDatIn <= BusDividerIfcWishboneUp.DatOut;
    JoinAck <= BusDividerIfcWishboneUp.Ack; 
    
    i_BusDividerIfcWishbone : entity work.BusDividerIfcWishbone
        port map(
            Clk => Clk,
            Rst => Rst,
            WishboneDown => BusDividerIfcWishboneDown,
            WishboneUp => BusDividerIfcWishboneUp,
            Trace => BusDividerIfcTrace,
            BusDividerBlkDown => BusDividerIfcBusDividerBlkDown,
            BusDividerBlkUp => BusDividerIfcBusDividerBlkUp
        );
                
    InterruptCollectorIfcWishboneDown.Adr <= BusDividerIfcBusDividerBlkDown.BusDelegate0Adr(InterruptCollectorIfcWishboneDown.Adr'left  downto 0);
    InterruptCollectorIfcWishboneDown.Sel <= BusDividerIfcBusDividerBlkDown.BusDelegate0Sel;
    InterruptCollectorIfcWishboneDown.We <= BusDividerIfcBusDividerBlkDown.BusDelegate0We;
    InterruptCollectorIfcWishboneDown.Stb <= BusDividerIfcBusDividerBlkDown.BusDelegate0Stb;
    InterruptCollectorIfcWishboneDown.Cyc <= BusDividerIfcBusDividerBlkDown.BusDelegate0Cyc;
    InterruptCollectorIfcWishboneDown.DatIn <= BusDividerIfcBusDividerBlkDown.BusDelegate0DatIn;
    
    BusDividerIfcBusDividerBlkUp.BusDelegate0Ack <= InterruptCollectorIfcWishboneUp.Ack;
    BusDividerIfcBusDividerBlkUp.BusDelegate0DatOut <= InterruptCollectorIfcWishboneUp.DatOut;

    i_InterruptCollectorIfcWishbone : entity work.InterruptCollectorIfcWishbone
        port map(
            Clk => Clk,
            Rst => Rst,
            WishboneDown => InterruptCollectorIfcWishboneDown,
            WishboneUp => InterruptCollectorIfcWishboneUp,
            Trace => InterruptCollectorIfcTrace,
            InterruptCollectorBlkDown => InterruptCollectorIfcInterruptCollectorBlkDown,
            InterruptCollectorBlkUp => InterruptCollectorIfcInterruptCollectorBlkUp
        );
                
    Mask(3) <= InterruptCollectorIfcInterruptCollectorBlkDown.Mask3;
    Mask(2) <= InterruptCollectorIfcInterruptCollectorBlkDown.Mask2;
    Mask(1) <= InterruptCollectorIfcInterruptCollectorBlkDown.Mask1;
    Mask(0) <= InterruptCollectorIfcInterruptCollectorBlkDown.Mask0;
    
    RequestWritten(3) <= InterruptCollectorIfcInterruptCollectorBlkDown.Request3Written;
    RequestWritten(2) <= InterruptCollectorIfcInterruptCollectorBlkDown.Request2Written;
    RequestWritten(1) <= InterruptCollectorIfcInterruptCollectorBlkDown.Request1Written;
    RequestWritten(0) <= InterruptCollectorIfcInterruptCollectorBlkDown.Request0Written;

    ServiceWritten(3) <= InterruptCollectorIfcInterruptCollectorBlkDown.Service3Written;
    ServiceWritten(2) <= InterruptCollectorIfcInterruptCollectorBlkDown.Service2Written;
    ServiceWritten(1) <= InterruptCollectorIfcInterruptCollectorBlkDown.Service1Written;
    ServiceWritten(0) <= InterruptCollectorIfcInterruptCollectorBlkDown.Service0Written;
    
    InterruptCollectorIfcInterruptCollectorBlkUp.Request3ToBeRead <= RequestToBeRead(3);
    InterruptCollectorIfcInterruptCollectorBlkUp.Request2ToBeRead <= RequestToBeRead(2);
    InterruptCollectorIfcInterruptCollectorBlkUp.Request1ToBeRead <= RequestToBeRead(1);
    InterruptCollectorIfcInterruptCollectorBlkUp.Request0ToBeRead <= RequestToBeRead(0);
    
    InterruptCollectorIfcInterruptCollectorBlkUp.Service3ToBeRead <= ServiceToBeRead(3);
    InterruptCollectorIfcInterruptCollectorBlkUp.Service2ToBeRead <= ServiceToBeRead(2);
    InterruptCollectorIfcInterruptCollectorBlkUp.Service1ToBeRead <= ServiceToBeRead(1);
    InterruptCollectorIfcInterruptCollectorBlkUp.Service0ToBeRead <= ServiceToBeRead(0);

    i_InterruptCollector : entity work.InterruptCollector
        generic map (
            BIT_WIDTH => 4,
            INTER_INTERRUPT_GAP => false,
            GAP_NUMMBER_OF_CLKS => 1,
            IS_LAST_IN_CHAIN => true
        )
        port map(
            Clk => Clk,
            Rst => Rst,
            InterruptIn => GeneratedInterrupt,
            ChainInUpInterrupt => '0',
            ChainInUpInitiateGap => '0',
            OutUpInterrupt => InterruptToDispatch,
            OutUpInitiateGap => open,
            Mask => Mask,
            RequestWritten => RequestWritten,
            WTransPulseInterruptRequestReg => InterruptCollectorIfcInterruptCollectorBlkDown.WTransPulseInterruptRequestReg,
            RequestToBeRead => RequestToBeRead,
            ServiceWritten => ServiceWritten,
            WTransPulseInterruptServiceReg => InterruptCollectorIfcInterruptCollectorBlkDown.WTransPulseInterruptServiceReg,
            ServiceToBeRead => ServiceToBeRead
        );
        
    InterruptGeneratorIfcWishboneDown.Adr <= BusDividerIfcBusDividerBlkDown.BusDelegate1Adr(InterruptGeneratorIfcWishboneDown.Adr'left downto 0);
    InterruptGeneratorIfcWishboneDown.Sel <= BusDividerIfcBusDividerBlkDown.BusDelegate1Sel;
    InterruptGeneratorIfcWishboneDown.DatIn <= BusDividerIfcBusDividerBlkDown.BusDelegate1DatIn;
    InterruptGeneratorIfcWishboneDown.We <= BusDividerIfcBusDividerBlkDown.BusDelegate1We;
    InterruptGeneratorIfcWishboneDown.Stb <= BusDividerIfcBusDividerBlkDown.BusDelegate1Stb;
    InterruptGeneratorIfcWishboneDown.Cyc <= BusDividerIfcBusDividerBlkDown.BusDelegate1Cyc;
    
    BusDividerIfcBusDividerBlkUp.BusDelegate1DatOut <= InterruptGeneratorIfcWishboneUp.DatOut;
    BusDividerIfcBusDividerBlkUp.BusDelegate1Ack <= InterruptGeneratorIfcWishboneUp.Ack;
    
    
    i_InterruptGeneratorIfcWishbone : entity work.InterruptGeneratorIfcWishbone
        port map(
            Clk => Clk,
            Rst => Rst,
            WishboneDown => InterruptGeneratorIfcWishboneDown,
            WishboneUp => InterruptGeneratorIfcWishboneUp,
            Trace => InterruptGeneratorIfcTrace,
            InterruptGeneratorBlkDown => InterruptGeneratorIfcInterruptGeneratorBlkDown,
            InterruptGeneratorBlkUp => InterruptGeneratorIfcInterruptGeneratorBlkUp
        );
        
    ChannelOperation(3) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ControlReg_ChannelOperation3;
    ChannelOperation(2) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ControlReg_ChannelOperation2;
    ChannelOperation(1) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ControlReg_ChannelOperation1;
    ChannelOperation(0) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ControlReg_ChannelOperation0;
                      
    InterruptGeneratorIfcInterruptGeneratorBlkUp.StatusReg_ChannelStatus3 <= ChannelStatus(3);
    InterruptGeneratorIfcInterruptGeneratorBlkUp.StatusReg_ChannelStatus2 <= ChannelStatus(2);
    InterruptGeneratorIfcInterruptGeneratorBlkUp.StatusReg_ChannelStatus1 <= ChannelStatus(1);
    InterruptGeneratorIfcInterruptGeneratorBlkUp.StatusReg_ChannelStatus0 <= ChannelStatus(0);
    
    ChargedCount(3) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ChargedCountReg3_Count;
    ChargedCount(2) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ChargedCountReg2_Count;
    ChargedCount(1) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ChargedCountReg1_Count;
    ChargedCount(0) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ChargedCountReg0_Count;
                        
    InterruptGeneratorIfcInterruptGeneratorBlkUp.ActualCountReg3_Count <= ActualCount(3);
    InterruptGeneratorIfcInterruptGeneratorBlkUp.ActualCountReg2_Count <= ActualCount(2);
    InterruptGeneratorIfcInterruptGeneratorBlkUp.ActualCountReg1_Count <= ActualCount(1);
    InterruptGeneratorIfcInterruptGeneratorBlkUp.ActualCountReg0_Count <= ActualCount(0);
    
    InterruptGeneratorIfcInterruptGeneratorBlkUp.FailureCountReg3_Count <= FailureCount(3);
    InterruptGeneratorIfcInterruptGeneratorBlkUp.FailureCountReg2_Count <= FailureCount(2);
    InterruptGeneratorIfcInterruptGeneratorBlkUp.FailureCountReg1_Count <= FailureCount(1);
    InterruptGeneratorIfcInterruptGeneratorBlkUp.FailureCountReg0_Count <= FailureCount(0);
    
    Interval(3) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.IntervalReg3_Interval;
    Interval(2) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.IntervalReg2_Interval;
    Interval(1) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.IntervalReg1_Interval;
    Interval(0) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.IntervalReg0_Interval;
    
    ReferenceCount(3) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ReferenceCountReg3_Count;
    ReferenceCount(2) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ReferenceCountReg2_Count;
    ReferenceCount(1) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ReferenceCountReg1_Count;
    ReferenceCount(0) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.ReferenceCountReg0_Count;
    
    WRegPulseReferenceCount(3) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.WRegPulseReferenceCountReg3;
    WRegPulseReferenceCount(2) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.WRegPulseReferenceCountReg2;
    WRegPulseReferenceCount(1) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.WRegPulseReferenceCountReg1;
    WRegPulseReferenceCount(0) <= InterruptGeneratorIfcInterruptGeneratorBlkDown.WRegPulseReferenceCountReg0;
                        
    i_InterruptGenerator : entity work.InterruptGenerator
        generic map(
            ClkPeriodInNs => 10
        )
        port map(
            Clk => Clk,
            Rst => Rst,
            InterruptOut => GeneratedInterrupt,
            FailureOut => GeneratorFailure,
            ChannelOperation => ChannelOperation,
            ChannelStatus => ChannelStatus,
            ChargedCount => ChargedCount,
            ActualCount => ActualCount,
            FailureCount => FailureCount,
            Interval => Interval,
            ReferenceCount => ReferenceCount,
            WRegPulseReferenceCount => WRegPulseReferenceCount
        );
                  
end architecture;