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

entity InterruptCollector is
    generic (
        BIT_WIDTH : positive := 1;
        INTER_INTERRUPT_GAP_NUMMBER_OF_CLKS : natural := 1;
        IS_LAST_IN_CHAIN : boolean := true
    );
    port (
        Clk : in std_logic;
        Rst : in std_logic;
        InterruptIn : in std_logic_vector(BIT_WIDTH - 1 downto 0);
        ChainInitiateGap : in std_logic;
        ChainInterruptUp : in std_logic;
        InterruptUp : out std_logic;
        Mask : in std_logic_vector(BIT_WIDTH - 1 downto 0);
        RequestWritten : in std_logic_vector(BIT_WIDTH - 1 downto 0);
        WTransPulseInterruptRequestReg : in std_logic;
        RequestToBeRead : out std_logic_vector(BIT_WIDTH - 1 downto 0);
        ServiceWritten : in std_logic_vector(BIT_WIDTH - 1 downto 0);
        WTransPulseInterruptServiceReg : in std_logic;
        ServiceToBeRead : out std_logic_vector(BIT_WIDTH - 1 downto 0)
    );
end entity;

architecture RTL of InterruptCollector is
    
    signal GapCount : unsigned(get_num_bits(INTER_INTERRUPT_GAP_NUMMBER_OF_CLKS) downto 0);
    signal ThisInterruptUp : std_logic;
    signal ThisInitiateGap : std_logic;
    
begin

      
    ThisInterruptUp <= '1' when unsigned(Mask and RequestToBeRead) /= 0 else '0';
      
    prcRequestAndService : process ( Clk, Rst) is
    begin
        if Rst then
            RequestToBeRead <= (others => '0');
            ServiceToBeRead <= (others => '0');
            ThisInitiateGap <= '0';          
        elsif rising_edge(Clk) then
            ThisInitiateGap <= '0'; -- default assignment
                   
            for i in 0 to BIT_WIDTH - 1 loop
            
                if ServiceToBeRead(i) then
                    RequestToBeRead(i) <= '0'; -- same request can only be set again after its service has ended
                elsif InterruptIn(i) then
                    RequestToBeRead(i) <= '1'; 
                end if;
                
                if RequestWritten(i) and WTransPulseInterruptRequestReg then
                    ServiceToBeRead(i) <= '1';
                    RequestToBeRead(i) <= '0';
                    ThisInitiateGap <= '1';                               
                end if;
                
                if ServiceWritten(i) and WTransPulseInterruptServiceReg then
                    ServiceToBeRead(i) <= '0';
                end if;        
                             
            end loop;
            
        end if;  
    end process;
    
    genLastInChain: if IS_LAST_IN_CHAIN generate
        InterruptUp <= ThisInterruptUp or ChainInterruptUp when ThisInitiateGap = '0' and ChainInitiateGap = '0' and GapCount = 0 else '0';
    
        prcCountGap : process ( Clk, Rst) is
        begin
            if Rst then
                GapCount <= (others => '0');
            elsif rising_edge(Clk) then              
                if ThisInitiateGap or ChainInitiateGap then
                    GapCount <= to_unsigned(INTER_INTERRUPT_GAP_NUMMBER_OF_CLKS, GapCount'length);
                elsif GapCount > 0 then
                    GapCount <= GapCount - 1;
                end if;                      
            end if;  
        end process;
    end generate;
    
    genPredecessorInChain: if not IS_LAST_IN_CHAIN generate
        InterruptUp <= ThisInterruptUp or ChainInterruptUp;
    end generate;
    
end architecture;
