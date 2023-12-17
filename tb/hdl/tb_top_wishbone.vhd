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
    
library eccelerators;
    use eccelerators.basic.all;
    
use work.InterruptCollectorIfcPackage.all;
use work.tb_bus_pkg.all;
use work.tb_signals_pkg.all;
use work.tb_base_pkg.all;
use work.InterruptGeneratorIfcPackage.all;
use work.BusDividerIfcPackage.all;

entity tb_top_wishbone is
    generic (
        stimulus_path : string := "../../tb/simstm/";
        stimulus_file : string := "TestMainWishbone.stm"
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
    signal InterruptToCpu : std_logic;
    
    signal ChannelOperation : std_logic_vector(1 downto 0);
    signal ChannelStatus : std_logic_vector(1 downto 0);
    signal ChargedCount : array_of_std_logic_vector(1 downto 0)(31 downto 0);
    signal ActualCount : array_of_std_logic_vector(1 downto 0)(31 downto 0);
    signal FailureCount : array_of_std_logic_vector(1 downto 0)(31 downto 0);
    signal Interval : array_of_std_logic_vector(1 downto 0)(31 downto 0);
    signal ReferenceCount : array_of_std_logic_vector(1 downto 0)(31 downto 0);
    signal WRegPulseReferenceCount: std_logic_vector(1 downto 0);
    
begin

    Rst <= transport '0' after 100 ns;
    Clk <= transport (not Clk) and (not SimDone)  after 10 ns / 2; -- 100MHz
    
    signals_in0.in_signal <= GeneratorFailure;
    signals_in0.in_signal_1 <= (others => '0');
    signals_in0.in_signal_2 <= signals_out1.out_signal_2;
    signals_in0.in_signal_3 <= signals_out1.out_signal_3;
    signals_in0.Interrupt_4 <= InterruptToCpu;
    
    signals_in1.in_signal <= GeneratorFailure;
    signals_in1.in_signal_1 <= (others => '0');
    signals_in1.in_signal_2 <= signals_out0.out_signal_2;
    signals_in1.in_signal_3 <= signals_out0.out_signal_3;
    signals_in1.Interrupt_4 <= InterruptToCpu;
    
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
            marker => marker1,
            signals_in => signals_in1,
            signals_out => signals_out1,
            bus_down => bus_down1,
            bus_up => bus_up1
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
    BusDividerIfcWishboneDown.Adr <= JoinAdr;
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
                
    InterruptCollectorIfcWishboneDown.Adr <= BusDividerIfcBusDividerBlkDown.BusDelegate0Adr(InterruptCollectorIfcWishboneDown.Adr'LENGTH - 1 downto 0);
    InterruptCollectorIfcWishboneDown.Sel <= BusDividerIfcBusDividerBlkDown.BusDelegate0Sel;
    InterruptCollectorIfcWishboneDown.We <= BusDividerIfcBusDividerBlkDown.BusDelegate0We;
    InterruptCollectorIfcWishboneDown.Stb <= BusDividerIfcBusDividerBlkDown.BusDelegate0Stb;
    InterruptCollectorIfcWishboneDown.Cyc <= BusDividerIfcBusDividerBlkDown.BusDelegate0Cyc;
    
    BusDividerIfcBusDividerBlkUp.BusDelegate0Ack <= InterruptCollectorIfcWishboneUp.Ack;
    
    InterruptCollectorIfcWishboneDown.DatIn <= BusDividerIfcBusDividerBlkUp.BusDelegate0DatOut;
    BusDividerIfcBusDividerBlkDown.BusDelegate0DatIn <= InterruptCollectorIfcWishboneUp.DatOut;

    
    
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


    i_InterruptCollector : entity work.InterruptCollector
        generic map (
            BIT_WIDTH => 4
        )
        port map(
            Clk => Clk,
            Rst => Rst,
            InterruptIn => GeneratedInterrupt,
            InterruptOut => InterruptToCpu,
            Mask => InterruptCollectorIfcInterruptCollectorBlkDown.Mask,
            RequestWritten => InterruptCollectorIfcInterruptCollectorBlkDown.RequestWritten,
            WTransPulseInterruptRequestReg => InterruptCollectorIfcInterruptCollectorBlkDown.WTransPulseInterruptRequestReg,
            RequestToBeRead => InterruptCollectorIfcInterruptCollectorBlkUp.RequestToBeRead,
            ServiceWritten => InterruptCollectorIfcInterruptCollectorBlkDown.ServiceWritten,
            WTransPulseInterruptServiceReg => InterruptCollectorIfcInterruptCollectorBlkDown.WTransPulseInterruptServiceReg,
            ServiceToBeRead => InterruptCollectorIfcInterruptCollectorBlkUp.ServiceToBeRead
        );
        
    InterruptGeneratorIfcWishboneDown.Adr <= BusDividerIfcBusDividerBlkDown.BusDelegate1Adr(InterruptGeneratorIfcWishboneDown.Adr'LENGTH - 1 downto 0);
    InterruptGeneratorIfcWishboneDown.Sel <= BusDividerIfcBusDividerBlkDown.BusDelegate1Sel;
    InterruptGeneratorIfcWishboneDown.DatIn <= BusDividerIfcBusDividerBlkDown.BusDelegate1DatOut;
    InterruptGeneratorIfcWishboneDown.We <= BusDividerIfcBusDividerBlkDown.BusDelegate1We;
    InterruptGeneratorIfcWishboneDown.Stb <= BusDividerIfcBusDividerBlkDown.BusDelegate1Stb;
    InterruptGeneratorIfcWishboneDown.Cyc <= BusDividerIfcBusDividerBlkDown.BusDelegate1Cyc;
    
    BusDividerIfcBusDividerBlkUp.BusDelegate1DatIn <= InterruptCollectorIfcWishboneUp.DatOut;
    BusDividerIfcBusDividerBlkUp.BusDelegate1Ack <= InterruptCollectorIfcWishboneUp.Ack;
    
    
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
            ClkPeriodInNs => 100
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