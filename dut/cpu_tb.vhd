
entity cpu_tb is
   end;

library ieee;
library work;
use ieee.std_logic_1164.all;
use work.arm_types.all;

architecture arch of cpu_tb is

component cpu
    generic (
       CACHE_BLOCK_BITWIDTH : natural := 5
    );
    port(
        -- Globals
        clk   : in std_logic;
        reset : in std_logic;
        
        --Avalon Master Interface for instructions
        avm_inst_waitrequest   : in  std_logic;
        avm_inst_readdatavalid : in  std_logic;
        avm_inst_readdata      : in  std_logic_vector(31 downto 0);
        avm_inst_read          : out std_logic;
        avm_inst_burstcount    : out std_logic_vector(CACHE_BLOCK_BITWIDTH-2 downto 0);
        avm_inst_address       : out std_logic_vector(31 downto 0);
        
        --Avalon Master Interface for data
        avm_data_waitrequest   : in  std_logic;
        avm_data_readdatavalid : in  std_logic;
        avm_data_readdata      : in  std_logic_vector(31 downto 0);
        avm_data_read          : out std_logic;
        avm_data_writedata     : out std_logic_vector(31 downto 0);
        avm_data_write         : out std_logic;
        avm_data_byteen        : out std_logic_vector(3 downto 0);
        avm_data_burstcount    : out std_logic_vector(4 downto 0);
        avm_data_address       : out std_logic_vector(31 downto 0);
        
        --Interrupt interface
        inr_irq                : in  std_logic_vector(31 downto 0) := (others => '0')
    );
end component;

signal clk   :std_logic := '0';
signal reset :std_logic := '0';
signal simend :std_logic := '0';
signal avm_inst_read  :std_logic;
signal avm_data_read  :std_logic;
signal avm_data_write :std_logic;
signal avm_inst_burstcount :std_logic_vector(3 downto 0);
signal avm_inst_address :std_logic_vector(31 downto 0);
signal avm_data_writedata :std_logic_vector(31 downto 0);
signal avm_data_address :std_logic_vector(31 downto 0);
signal avm_data_burstcount :std_logic_vector(4 downto 0);
signal avm_data_byteen :std_logic_vector(3 downto 0);
signal avm_inst_waitrequest :std_logic;
signal avm_inst_readdatavalid :std_logic;
signal avm_inst_readdata :std_logic_vector(31 downto 0);
signal avm_data_waitrequest :std_logic;
signal avm_data_readdatavalid :std_logic;
signal avm_data_readdata :std_logic_vector(31 downto 0);




begin

dut: cpu
generic map (
    CACHE_BLOCK_BITWIDTH => 5
    )
port map (
    clk => clk,
    reset => reset,
    avm_inst_waitrequest => avm_inst_waitrequest,
    avm_inst_readdatavalid => avm_inst_waitrequest,
    avm_inst_readdata => avm_inst_readdata,
    avm_inst_read => avm_inst_read,
    avm_inst_burstcount => avm_inst_burstcount,
    avm_inst_address => avm_inst_address,
    avm_data_waitrequest => avm_data_waitrequest,
    avm_data_readdatavalid => avm_data_readdatavalid,
    avm_data_readdata => avm_data_readdata,
    avm_data_read => avm_data_read,
    avm_data_writedata => avm_data_writedata,
    avm_data_write => avm_data_write,
    avm_data_byteen => avm_data_byteen,
    avm_data_burstcount => avm_data_burstcount,
    avm_data_address => avm_data_address,
    inr_irq => (others => '0')
    );

clock : process
begin
    if simend = '0' then
        wait for 1 ns; clk <= not clk;
    else
        wait;
    end if;
end process clock;

start : process
begin
    wait for 5 ns; reset <= '1';
    wait for 4 ns; reset <= '0';
    wait for 4 ns;
    

    wait for 10 ns; simend <= '1';
    assert false report "NONE";
    wait;
end process start;
end arch;
